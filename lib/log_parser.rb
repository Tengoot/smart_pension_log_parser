# frozen_string_literal: true

require 'set'

class LogParser
  PATH_REGEX = /(?<path>[^ ]+)/.freeze
  ADDRESS_REGEX = /(?<address>(\d{1,3}\.){3}\d{1,3})/.freeze
  VISIT_REGEX = /#{PATH_REGEX} #{ADDRESS_REGEX}/.freeze

  class InvalidFormat < StandardError; end

  def initialize(logfile_path)
    @logfile_path = logfile_path
  end

  def visits
    parse
  end

  private

  attr_reader :logfile_path

  def parse
    File.foreach(logfile_path)
        .map(&method(:parse_visit))
    visits_data.values
  end

  def parse_visit(line)
    match = line.match(VISIT_REGEX)
    raise InvalidFormat unless match

    count_visit(match[:path], match[:address])
  end

  def count_visit(path, ip)
    visits_data[path].count_visitor(ip)
  end

  def visits_data
    @visits_data ||= Hash.new { |hash, key| hash[key] = Visit.new(address: key, ips: Set.new) }
  end
end
