# frozen_string_literal: true

describe LogParser do
  describe '#visits' do
    subject(:visits_call) { described_class.new(log_path).visits }

    let(:log_path) { File.join(File.dirname(__FILE__), 'fixtures', 'test.log') }

    it 'returns array' do
      expect(visits_call).to be_an(Array)
    end

    it 'returns Visit Struct as an element' do
      expect(visits_call).to all(be_a(Struct))
    end

    it 'returns four elements' do
      expect(visits_call.size).to eq(4)
    end

    context 'when log_path is invalid' do
      let(:log_path) { File.join(File.dirname(__FILE__), 'fixtures', 'missing.log') }

      it 'raises Error' do
        expect { visits_call }.to raise_error(Errno::ENOENT)
      end
    end

    context 'when log file has lines in invalid format' do
      let(:log_path) { File.join(File.dirname(__FILE__), 'fixtures', 'invalid.log') }

      it 'raises Error' do
        expect { visits_call }.to raise_error(LogParser::InvalidFormat)
      end
    end
  end
end
