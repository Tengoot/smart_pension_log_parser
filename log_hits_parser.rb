# frozen_string_literal: true

require_relative 'lib/log_parser'

logpath = ARGV[0]
LogParser.new(logpath)

puts parser.visits
