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

module TweakIRB
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

include TweakIRB
