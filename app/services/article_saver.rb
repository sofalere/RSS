class ArticleSaver
  MAX_ARTICLES = 100

  def self.run(articles)
    if Article.count >= MAX_ARTICLES
      oldest_articles = Article.order(pub_date: :asc).limit(Article.count - (MAX_ARTICLES - 1))
      Article.where(id: oldest_articles.pluck(:id)).delete_all
    end

    if articles.is_a?(Array)
      new_links = articles.map { |article| article['link'] }
      existing_links = Article.where(link: new_links).pluck(:link)

      new_articles = articles.select { |article| !existing_links.include?(article['link']) }
      Article.insert_all(new_articles)
    else
      puts "Invalid input format for saving articles to database"
    end
  end
end