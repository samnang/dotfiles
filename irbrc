require 'rubygems' if RUBY_VERSION[2] == ?8 # rubygems is only needed in 1.8
require 'irbtools'

FancyIrb.start :colorize => {
	:stdout => :yellow
}
