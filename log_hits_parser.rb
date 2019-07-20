# frozen_string_literal: true

require_relative 'lib/types'
require_relative 'lib/visit'
require_relative 'lib/log_parser'
require_relative 'lib/visits_presenter'

logpath = ARGV.first
parser = LogParser.new(logpath)
presenter = VisitsPresenter.new(parser.visits)

puts 'Visits sorted by hit count'
puts presenter.sorted_by_count

puts "\nVisits sorted by unique hits count"
puts presenter.sorted_by_unique_count
