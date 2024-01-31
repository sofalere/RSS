require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without link" do
    article = Article.new(description: "valid desciption", title: "valid title", pub_date: '2024-01-31 12:34:56')
    assert_not article.save, "Saved the article without a link"
  end

  test "should not save article without title" do
    article = Article.new(description: "valid desciption", pub_date: '2024-01-31 12:34:56', link:"valid_link")
    assert_not article.save, "Saved the article without a title"
  end

  test "should not save article without description" do
    article = Article.new(title: "valid title", pub_date: '2024-01-31 12:34:56', link:"valid_link")
    assert_not article.save, "Saved the article without a description"
  end

  test "should not save article without pub_date" do
    article = Article.new(description: "valid desciption", link:"valid_link", title: "valid title")
    assert_not article.save, "Saved the article without a pub_date"
  end

  test "should save article with valid link, date, title, and description" do
    article = Article.new(description: "valid desciption", title: "valid title", pub_date: '2024-01-31 12:34:56', link:"valid_link")
    assert article.save, "Saved the article"
  end

  test "should not save 2 articles with the same link" do
    Article.create(description: "valid description", pub_date: '2024-01-31 12:34:56', title: "valid title", link: "not_unique_link")
    article = Article.new(description: "valid description", pub_date: '2024-01-31 12:34:56', title: "valid title", link: "not_unique_link")
  
    assert_not article.save, "Saved an article with a link that is already used by another article"
  end
end
