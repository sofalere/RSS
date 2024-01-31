require 'test_helper'

class ArticleFunctionTest < ActionDispatch::IntegrationTest
  test "should save new articles in the database" do
    old_article_count = Article.count
    
    RssDataFetcher.fetch_and_save
    
    new_article_count = Article.count

    assert_not_equal old_article_count, new_article_count

    new_articles = Article.last(15) # counts on API returning atleast 15 articles
    new_articles.each do |article|
      assert_not_nil article.title
      assert_not_nil article.description
      assert_not_nil article.pub_date
      assert_not_nil article.link
      assert_equal false, article.read
    end
  end
end