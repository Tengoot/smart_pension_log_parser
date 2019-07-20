# frozen_string_literal: true

describe Visit do
  describe '#count_visitor' do
    subject(:visit) { described_class.new(address: '/path', ips: Set.new) }

    let(:ip) { '444.701.448.104' }
    let(:another_ip) { '444.701.448.105' }

    context 'when first visit occurs' do
      it 'adds 1 to count' do
        expect { visit.count_visitor(ip) }.to change(visit, :count).by(1)
      end

      it 'adds 1 to unique count' do
        expect { visit.count_visitor(ip) }.to change(visit, :unique_count).by(1)
      end

      it 'contains visitor ip in ips' do
        visit.count_visitor(ip)
        expect(visit.ips).to include(ip)
      end
    end

    context 'when another visitor is present' do
      before { visit.count_visitor(another_ip) }

      it 'adds 1 to count' do
        expect { visit.count_visitor(ip) }.to change(visit, :count).by(1)
      end

      it 'adds 1 to unique count' do
        expect { visit.count_visitor(ip) }.to change(visit, :unique_count).by(1)
      end

      it 'contains visitor ip in ips' do
        visit.count_visitor(ip)
        expect(visit.ips).to include(ip)
      end
    end

    context 'when ip address visits twice' do
      before { visit.count_visitor(ip) }

      it 'adds 1 to count' do
        expect { visit.count_visitor(ip) }.to change(visit, :count).by(1)
      end

      it 'adds 1 to unique count' do
        expect { visit.count_visitor(ip) }.not_to change(visit, :unique_count)
      end

      it 'contains visitor ip in ips' do
        visit.count_visitor(ip)
        expect(visit.ips).to include(ip)
      end
    end
  end
end
