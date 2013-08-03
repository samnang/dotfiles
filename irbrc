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
try_require 'looksee'
try_require 'awesome_print' do
  AwesomePrint.defaults = {
    :limit => true
  }
end

module TweakIRB
  def self.rails?
    ($0 == 'irb' && ENV['RAILS_ENV']) || ($0 == 'script/rails' && ::Rails.env)
  end

  def self.included(base)
    base.send(:include, Core)
    #base.send(:include, Rails) if rails?
  end

  module Rails
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
  end

  module Core
    unless respond_to?(:singleton_class)
      Kernel.module_eval do
        def singleton_class
          class << self; self; end
        end
      end
    end

    def mm
      (methods - self.class.superclass.instance_methods).sort
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
  end
end

include TweakIRB
