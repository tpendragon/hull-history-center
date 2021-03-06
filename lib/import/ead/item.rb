module Ead
  module Item
    class << self

      def root_xpath
        'c[@level = "item"]'
      end

      # Map the name of the field to its xpath within the EAD xml
      def fields_map
        {
          id: 'did/unitid[@label = "Reference"]',
          title: 'did/unittitle'
        }
      end

      def to_solr(attributes, doc = {})
        doc.tap do |fields|
          fields['id'] = attributes[:id]
          fields['title_tesim'] = attributes[:title]
        end
      end
    end
  end
end
