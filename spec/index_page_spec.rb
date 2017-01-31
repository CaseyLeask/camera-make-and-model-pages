require 'oga'
require_relative '../lib/index_page'

describe IndexPage do
  let(:index_page) { IndexPage.new(works) }
  let(:template) { File.read('lib/template.html.erb') }

  context 'given the test sample of valid works' do
    let(:works) { Oga.parse_xml(File.open('spec/fixtures/works.xml')).css('works work') }
    let(:expected_result) { File.read('spec/fixtures/expected_index_page.html') }

    context 'calling generate' do
      let(:generate) { index_page.generate(template) }

      it 'should give a valid index page' do
        expect(generate['index.html']).to eq(expected_result)
      end
    end
  end
end
