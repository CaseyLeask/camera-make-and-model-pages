require 'oga'
require_relative '../lib/model_pages'

describe ModelPages do
  let(:make_page) { ModelPages.new(works) }
  let(:template) { File.read('lib/template.html.erb') }

  context 'given valid works' do
    let(:works) { Oga.parse_xml(File.open('spec/fixtures/works.xml')).css('works work') }
    let(:nikon) do
      File.read('spec/fixtures/expected_models/nikonD80.html')
    end

    context 'calling generate' do
      let(:generate) { make_page.generate(template) }

      it 'should include a valid nikon D80 page' do
        expect(generate['NIKON%20D80.html']).to eq(nikon)
      end
    end
  end
end
