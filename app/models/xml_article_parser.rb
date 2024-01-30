# require 'nokogiri'

# class XMLArticleParser

#   def initialize(XML_string)
#     @doc = Nokogiri::XML(XML_string, nil, 'EUC-JP')
#     @articles = []
#   end

#   def articles
    
#   end
 
#   private

#   def article_data 
#     @doc.remove_namespaces!

#     @doc.xpath('//item').map do |item|
#       item = {
#         'title'       => item.at('./title').text,
#         'link'        => item.at('./link').text,
#         'description' => item.at('./description').text,
#         'pub_date'    => item.at('./date').text
#       }

#       item['description'] = item['description'].split('<p>', 2).first if item['description']
#     end
#   end

# end