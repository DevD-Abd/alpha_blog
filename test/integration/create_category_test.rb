require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com", password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "get new category form and create category" do
    get new_category_url
    assert_response :success

    assert_difference("Category.count", 1) do
      post categories_url, params: { category: { name: "Travel" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    # assert_match "Category was created successfully", flash[:notice]
    assert_match "Travel", response.body
  end

  test "invalid category submission results in failure" do
    get new_category_url
    assert_response :success

    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: " " } }
    end

    assert_match "errors", response.body
    assert_select "div.alert"
  end
end
