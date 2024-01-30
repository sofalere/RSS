require 'open-uri'
require 'nokogiri'

class ArticlesController < ApplicationController
  def index
    @articles = get_parsed_articles

    @articles.each{ |article| 
      begin 
        Article.create(article) 
      rescue ActiveRecord::RecordNotUnique => e
        p "Article already saved"
      end
    }
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
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
        'pub_date'        => item.at('./date').text
      }

      item['description'] = item['description'].split('<p>', 2).first if item['description']
      articles << item
    end
    
    articles
  end
end
