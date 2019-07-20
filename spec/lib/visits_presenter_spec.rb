# frozen_string_literal: true

# frozen_sring_literal: true

describe VisitsPresenter do
  subject(:presenter) { described_class.new(visits) }

  let(:visits) do
    [
      instance_double('Visit', address: '/', count: 10, unique_count: 2),
      instance_double('Visit', address: '/path/to/1', count: 0, unique_count: 0),
      instance_double('Visit', address: '/path/to', count: 5, unique_count: 4)
    ]
  end

  describe '#sorted_by_count' do
    let(:sorted_and_formatted_visits) do
      [
        '/ 10',
        '/path/to 5',
        '/path/to/1 0'
      ]
    end

    it 'returns array of sorted and formatted data about visits' do
      expect(presenter.sorted_by_count).to match_array(sorted_and_formatted_visits)
    end
  end

  describe '#sorted_by_unique_count' do
    let(:sorted_and_formatted_visits) do
      [
        '/path/to 4',
        '/ 2',
        '/path/to/1 0'
      ]
    end

    it 'returns array of sorted and formatted data about visits' do
      expect(presenter.sorted_by_unique_count).to match_array(sorted_and_formatted_visits)
    end
  end
end
