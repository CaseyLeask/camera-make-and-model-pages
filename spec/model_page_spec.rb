# frozen_string_literal: true

require 'oga'
require_relative '../lib/model_pages'

describe ModelPages do
  let(:make_page) { ModelPages.new(works) }
  let(:template) { File.read('lib/template.html.erb') }

  context 'given valid works' do
    let(:works) { Oga.parse_xml(File.open('spec/fixtures/works.xml')).css('works work') }

    let(:eos20d) { File.read('spec/fixtures/expected_models/CanonEOS20D.html') }
    let(:eos400) { File.read('spec/fixtures/expected_models/CanonEOS400DDIGITAL.html') }
    let(:dlux3) { File.read('spec/fixtures/expected_models/DLUX3.html') }
    let(:finepix) { File.read('spec/fixtures/expected_models/FinePixS6500fd.html') }
    let(:dmcfz30) { File.read('spec/fixtures/expected_models/DMCFZ30.html') }
    let(:nikon) { File.read('spec/fixtures/expected_models/nikonD80.html') }
    let(:slp1000) { File.read('spec/fixtures/expected_models/SLP1000SE.html') }

    context 'calling generate' do
      let(:generate) { make_page.generate(template) }

      it 'should give 7 pages' do
        expect(generate.length).to be 7
      end

      it 'should include a valid CanonEOS20D page' do
        expect(generate['CanonEOS20D.html']).to eq(eos20d)
      end

      it 'should include a valid CanonEOS400DDIGITAL page' do
        expect(generate['CanonEOS400DDIGITAL.html']).to eq(eos400)
      end

      it 'should include a valid DLUX3 page' do
        expect(generate['DLUX3.html']).to eq(dlux3)
      end

      it 'should include a valid FinePixS6500fd page' do
        expect(generate['FinePixS6500fd.html']).to eq(finepix)
      end

      it 'should include a valid DMCFZ30 page' do
        expect(generate['DMCFZ30.html']).to eq(dmcfz30)
      end

      it 'should include a valid nikon D80 page' do
        expect(generate['NIKOND80.html']).to eq(nikon)
      end

      it 'should include a valid SLP1000SE page' do
        expect(generate['SLP1000SE.html']).to eq(slp1000)
      end
    end
  end
end
