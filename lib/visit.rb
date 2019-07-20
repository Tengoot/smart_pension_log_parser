# frozen_string_literal: true

require 'dry-struct'
require 'set'

class Visit < Dry::Struct
  attribute :address, Types::Strict::String
  attribute :ips, Types.Instance(Set)
  attribute :count, Types::Strict::Integer.default(0)
  attribute :unique_count, Types::Strict::Integer.default(0)

  def count_visitor(ip_address)
    self.unique_count += 1 unless ips.include?(ip_address)
    self.count += 1
    ips.add(ip_address)
  end

  private

  %i[count unique_count].each do |setter_name|
    define_method("#{setter_name}=") do |value|
      self.attributes = attributes.merge(setter_name => value)
    end
  end

  def attributes=(new_attributes)
    @attributes = attributes.merge(new_attributes)
  end
end
