require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  test "should show main articles list" do
    visit articles_path
    assert_selector "h1", text: "Articles"
  end

  test "should toggle read status on click" do
    visit articles_path

    first_article_checkbox = find(".mark-read-checkbox", match: :first)
    initial_checkbox_value = first_article_checkbox[:checked]
    page.execute_script("document.getElementById('#{first_article_checkbox[:id]}').click();")

    assert_no_selector ".mark-read-checkbox[checked='#{initial_checkbox_value}']", wait: 5

    updated_checkbox_value = find(".mark-read-checkbox", match: :first)[:checked]
    assert_not_equal initial_checkbox_value, updated_checkbox_value
  end
end
