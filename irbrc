# ================= Helper methods ======================

def __require_gem!(name)
  require name
  yield if block_given?
rescue LoadError
  puts "=> Gem #{name} not found."
end

def __toggle_autocomplete!
  bool = IRB.conf[:USE_AUTOCOMPLETE]
  IRB.conf[:USE_AUTOCOMPLETE] = !bool
  Reline.autocompletion = !bool
end

if defined?(Rails)
  Rails.logger.level = :debug
  def toggle_query_log!
    logger = ActiveRecord::Base.logger
    logger.level = (logger.level == 0 ? :info : :debug)
  end
end

# =======================================================

require "rubygems"
require "irb"
require "irb/completion"

__require_gem! "amazing_print" do
  AmazingPrint.irb!
end

# Custom Prompt
# IRB.conf[:USE_READLINE] = true
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
if defined? Reline::Face
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: "#cad3f5", background: "#363a4f")
    conf.define(:enhanced, foreground: "#cad3f5", background: "#5b6078")
    conf.define(:scrollbar, foreground: "#c6a0f6", background: "#181926")
  end
else
  IRB.conf[:USE_AUTOCOMPLETE] = false
end
