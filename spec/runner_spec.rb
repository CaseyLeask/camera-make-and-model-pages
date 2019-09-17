# frozen_string_literal: true

require 'uri'
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
      let(:argv) { [''] }
      it 'should raise an error' do
        expect { runner }.to raise_error(ArgumentError)
      end
    end

    context 'with three values' do
      let(:argv) { ['', '', ''] }
      it 'should raise an error' do
        expect { runner }.to raise_error(ArgumentError)
      end
    end

    context 'with api_url and output_directory' do
      let(:argv) { [api_url, output_directory] }
      let(:api_url) { 'https://example.com/api' }
      let(:output_directory) { '.' }

      context 'given an invalid URL for api_url' do
        let(:api_url) { '^' }

        it 'should raise an error' do
          expect { runner }.to raise_error(URI::InvalidURIError)
        end
      end

      context 'given a relative URL for api_url' do
        let(:api_url) { 'api' }

        it 'should raise an error' do
          expect { runner }.to raise_error(URI::InvalidURIError)
        end
      end

      context 'given an absolute URL for api_url' do
        it 'should be accessible' do
          expect(runner.api_url.to_s).to eq(api_url)
        end
      end

      context 'given an invalid directory for output_directory' do
        let(:output_directory) { '' }
        it 'should raise an error' do
          expect { runner }.to raise_error(Errno::ENOENT)
        end
      end

      context 'given a non-existent directory for output_directory' do
        let(:output_directory) { 'non-existent' }

        around(:each) do |test|
          Dir.rmdir(output_directory) if Dir.exist?(output_directory)
          test.run
          Dir.rmdir(output_directory)
        end

        it 'should create the directory' do
          runner

          expect(Dir.exist?(output_directory)).to be true
        end

        it 'should be accessible' do
          expect(runner.output_directory.path).to eq(output_directory)
        end
      end

      context 'given an existing directory for output_directory' do
        let(:output_directory) { 'existing' }

        around(:each) do |test|
          Dir.mkdir(output_directory)
          test.run
          Dir.rmdir(output_directory)
        end

        it 'should be accessible' do
          expect(runner.output_directory.path).to eq(output_directory)
        end
      end
    end
  end
end
