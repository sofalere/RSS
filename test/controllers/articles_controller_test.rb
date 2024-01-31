require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_path
    assert_response :success
  end

  test "should get show" do
    get articles_path(1)
    assert_response :success
  end

  test "should update read status of article" do
    article = Article.create(description: "valid desciption", title: "valid title", pub_date: '2024-01-31 12:34:56', link:"valid_link")
  
    assert_difference("Article.where(read: true).count") do
      patch article_path(article), params: {id: article.id}
    end
  
    assert_equal true, article.reload.read
  end
end
