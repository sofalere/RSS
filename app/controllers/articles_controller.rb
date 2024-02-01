class ArticlesController < ApplicationController
  def index
    begin
      response = RssDataFetcher.run
      parsed_data = XmlDataParser.run(response)
      ArticleSaver.run(parsed_data)
      @articles = Article.order(pub_date: :desc)
    rescue StandardError => e
      puts "An error occurred while fetching or processing the data: #{e.message}"
      @articles = []
    end
  end

  def show
    @article = find_article_by_id(params[:id])
  end

  def update
    @article = find_article_by_id(params[:id])

    begin
      @article.toggle_read_status
      @articles = Article.order(pub_date: :desc)
    rescue StandardError => e
      puts  "An error occurred while updating the data: #{e.message}"
      redirect_to root_path
      return
    end

    render :index, layout: 'application'
  end

  private

  def find_article_by_id(id)
    begin
      Article.find(id)
    rescue ActiveRecord::RecordNotFound => e
      puts "Article not found by ID: #{e.message}"
      redirect_to root_path
    end
  end
end
