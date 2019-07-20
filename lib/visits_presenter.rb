# frozen_string_literal: true

class VisitsPresenter
  def initialize(visits)
    @visits = visits
  end

  %i[count unique_count].each do |sort_key|
    define_method("sorted_by_#{sort_key}") do
      visits.sort_by(&sort_key).reverse.map do |single_visit|
        "#{single_visit.address} #{single_visit.send(sort_key)}"
      end
    end
  end

  private

  attr_reader :visits
end
