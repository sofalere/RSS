require 'open-uri'
require 'nokogiri'

class ArticlesController < ApplicationController
  def index
    RssDataFetcher.fetch_and_save
    @articles = Article.order(pub_date: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end
end
