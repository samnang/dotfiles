$LOAD_PATH << File.expand_path(".")

require 'rubygems' if RUBY_VERSION[2] == ?8 # rubygems is only needed in 1.8

# IRB settings
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:AUTO_INDENT]  = true
IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => ">> ",
  :PROMPT_S => "%l>> ",
  :PROMPT_C => ".. ",
  :PROMPT_N => ".. ",
  :RETURN => "=> %s\n"
}
IRB.conf[:PROMPT_MODE] = :CUSTOM
IRB.conf[:AT_EXIT] << Proc.new {puts "Bye, see you again soon :-)"}

def try_require(gem_name)
  begin
  require gem_name
  yield if block_given?
  
  rescue ScriptError
    puts "#{gem_name} has no found."
  end
end

# Load third party gems
try_require 'map_by_method'
try_require 'interactive_editor'
try_require 'looksee'
try_require 'awesome_print' do
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
end
try_require 'fancy_irb' do
  FancyIrb.start
end

module TweakIRB
  def self.included(base)
    base.send(:include, IO)
    base.send(:include, Documentation)
    base.send(:include, Rails)
    base.send(:include, Core)
  end

  module IO
    def dir
      `ls`.split("\n")
    end

    def cd(dir)
      Dir.chdir(dir)
      Dir.pwd
    end

    def pwd
      Dir.pwd
    end

    # http://timelessrepo.com/copy-paste
    # Installation: sudo apt-get install xclip
    def copy(str)
      ::IO.popen('xclip -i', 'w') { |f| f << str.to_s }
    end

    def paste
      `xclip -o`
    end

    # Evaluate the code on the clipboard.
    def ep
      IRB.CurrentContext.workspace.evaluate(self, paste)
    end
  end

  module Documentation
    RI_DELEMITER = "ri_"

    def ri(method = nil)
      unless method && method =~ /^[A-Z]/
        klass = self.kind_of?(Class) ? name : self.class.name
        method = [klass, method].compact.join('#')
      end

      system 'ri', method.to_s
    end

    def method_missing(method_sym, *args)
      name = method_sym.to_s

      return ri(name[RI_DELEMITER.length..-1]) if name.start_with? RI_DELEMITER

      super
    end
  end

  module Rails
    extend self

    def rails?
      ($0 == 'irb' && ENV['RAILS_ENV']) || ($0 == 'script/rails' && ::Rails.env)
    end

    if rails?
      def change_log(stream)
        ::ActiveRecord::Base.logger = Logger.new(stream)
        ::ActiveRecord::Base.clear_active_connections!
      end

      def show_log
        change_log(STDOUT) && true
      end

      def hide_log
        change_log(nil) && true
      end

      def sql(query)
        ::ActiveRecord::Base.connection.select_all(query)
      end

      try_require 'hirb' do
        Hirb.enable
      end
    end
  end

  module Core
    unless respond_to?(:singleton_class)
      Kernel.module_eval do
        def singleton_class
          class << self; self; end
        end
      end
    end
  end
end

class Object
  include TweakIRB

  def my_methods
    (methods - self.class.superclass.instance_methods).sort
  end

  # Reload IRB
  def reload
    puts "IRB has been reloaded."
    exec($0)
  end

  def clear
    system('clear')
  end

  # Quick benchmarking facility
  # Based on rue's irbrc => http://pastie.org/179534
  def quick(repetitions=100, &block)
    require 'benchmark'

    Benchmark.bmbm do |b|
      b.report {repetitions.times &block} 
    end
    nil
  end

  alias :reset :reload
  alias :restart :reload

  alias :cls :clear
  alias :mm :my_methods
  alias :m :method
  alias :q :exit
end
