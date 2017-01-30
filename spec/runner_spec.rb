require_relative '../lib/runner'

describe Runner do
  context 'given an argv' do
    let(:runner) { Runner.new(argv) }

    context 'with no values' do
      let(:argv) { [] }
      it 'should raise an error' do
        expect { runner }.to raise_error(ArgumentError)
      end
    end

    context 'with one value' do
      let(:argv) { [ '' ] }
      it 'should raise an error' do
        expect { runner }.to raise_error(ArgumentError)
      end
    end

    context 'with three values' do
      let(:argv) { [ '', '', '' ] }
      it 'should raise an error' do
        expect { runner }.to raise_error(ArgumentError)
      end
    end

    context 'with a valid api_url and output_directory' do
      let(:argv) { [ api_url, output_directory ] }
    end
  end
end
