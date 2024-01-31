class ArticleCleanup
  MAX_ARTICLES = 100

  def self.run
    if Article.count > MAX_ARTICLES
      articles_to_delete = Article.order(created_at: :asc).limit(Article.count - MAX_ARTICLES)

      articles_to_delete.each do |article|
        article.destroy
      end

      puts "Deleted #{articles_to_delete.count} oldest articles."
    else
      puts "No need to delete articles. Count is within the limit."
    end
  end
end