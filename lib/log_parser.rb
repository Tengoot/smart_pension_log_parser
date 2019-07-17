# frozen_string_literal: true

class LogParser
  PATH_REGEX = %r{(?<path>[^ ]+)}.freeze
  ADDRESS_REGEX = %r{(?<address>(\d{1,3}\.){3}\d{1,3})}.freeze
  VISIT_REGEX = %r{#{PATH_REGEX} #{ADDRESS_REGEX}}.freeze

  class InvalidFormat < StandardError; end

  Visit = Struct.new(:address, :ips, :count, :unique_count) do
    def initialize(*args)
      super
      self.ips ||= Set.new
      self.count ||= 0
      self.unique_count ||= 0
    end
  end

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

  def count_visit(path, address)
    visit = visits_data[path]
    visit.unique_count += 1 unless visit.ips.include?(address)
    visit.count += 1
    visit.ips.add(address)
  end

  def visits_data
    @visits_data ||= Hash.new { |hash, key| hash[key] = Visit.new(key) }
  end
end
