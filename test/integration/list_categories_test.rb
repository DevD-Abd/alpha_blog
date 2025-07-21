require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category1 = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test "should show categories listing" do
    get categories_url
    assert_response :success
    assert_select "a[href=?]", category_path(@category1), text: "View"
    assert_select "a[href=?]", category_path(@category2), text: "View"
    assert_select "h5", text: @category1.name.capitalize
    assert_select "h5", text: @category2.name.capitalize
  end
end
