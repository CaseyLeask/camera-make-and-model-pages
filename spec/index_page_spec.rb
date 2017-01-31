require 'oga'
require_relative '../lib/index_page'

describe IndexPage do
  let(:index_page) { IndexPage.new(works) }
  let(:template) { File.read('lib/template.html.erb') }
  let(:generate) { index_page.generate(template) }

  context 'given the test sample of valid works' do
    let(:works) { Oga.parse_xml(File.open('spec/fixtures/works.xml')).css('works work') }
    let(:expected_result) { File.read('spec/fixtures/expected_index_page.html') }

    it 'should generate a valid index page' do
      expect(generate).to eq(expected_result)
    end
  end
end