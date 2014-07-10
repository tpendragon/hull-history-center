require 'rails_helper'
require_relative '../../../lib/import/ead'

describe Ead::Importer do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_ead_files')) }
  let(:ead_file) { File.join(fixtures_path, 'U_DDH.xml') }

  describe '.import' do
    it "imports the correct number of items" do
      Blacklight.solr.delete_by_query('*:*', params: {commit: true})
      Ead::Importer.import([ead_file])
      expect(Blacklight.solr.select('q' => "*:*")['response']['numFound']).to eq 669
    end

    it "imports items correctly" do
      Ead::Importer.import([ead_file])
      doc = Blacklight.solr.select('q' => "FIXME")['response']['docs'].first
      expect(doc['id']).to eq "U DSG/1/1"
      expect(doc['title_tesim']).to eq ["File. Correspondence received from other poets, filed A-C"]
    end
  end

end