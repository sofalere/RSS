class ArticlesController < ApplicationController
  def index
    RssDataFetcher.fetch_and_save
    @articles = Article.order(pub_date: :desc)
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.toggle_read_status
    render json: { status: 'success', read: @article.read }
  end
end
