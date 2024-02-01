require 'nokogiri'

class XmlDataParser
  def self.run(file)
    doc = Nokogiri::XML(file, nil, 'EUC-JP')
    articles = []

    if doc && doc.xpath('//item')
      doc.remove_namespaces!
      doc.xpath('//item').each do |item|
        item = {
          'title'       => item.at('./title').text,
          'link'        => item.at('./link').text,
          'description' => item.at('./description').text,
          'pub_date'    => item.at('./date').text
        }

        item['description'] = item['description'].split('<p>', 2).first if item['description']
        articles << item
      end
    end

    articles
  end
end