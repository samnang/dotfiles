# ================= Helper methods ======================

def require_gem!(name)
  require name
  yield if block_given?
rescue LoadError
  puts "=> Gem #{name} not found."
end

if defined?(Rails)
  def toggle_query_log!
    logger = ActiveRecord::Base.logger
    logger.level = logger.level == 0 ? :info : :debug
  end
end

# =======================================================

require_gem! "amazing_print" do
  AmazingPrint.irb!
end
