require 'open-uri'
require 'nokogiri'

class ArticlesController < ApplicationController
  def index
    @articles = get_parsed_articles
    @articles.map{ |article| Article.create(article) }
    p @articles
  end

  def show
  end

  def get_parsed_articles
    url = "https://rss.slashdot.org/Slashdot/slashdotMain"
    response = Nokogiri::XML(URI.open(url), nil, 'EUC-JP')
    articles = []

    response.remove_namespaces!
    response.xpath('//item').each do |item|
      item = {
        'title'       => item.at('./title').text,
        'link'        => item.at('./link').text,
        'description' => item.at('./description').text,
        'pub-date'        => item.at('./date').text
      }

      item['description'] = item['description'].split('<p>', 2).first if item['description']
      articles << item
    end
    
    articles
  end
end
