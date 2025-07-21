require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  test "should sign up a new user and redirect to articles page" do
    # Visit the signup page
    get signup_path
    assert_response :success
    assert_select "form"
    
    # Test that a new user is created
    assert_difference 'User.count', 1 do
      post users_path, params: { 
        user: { 
          username: "testuser", 
          email: "test@example.com", 
          password: "password" 
        } 
      }
    end
    
    # Follow the redirect after successful sign up
    follow_redirect!
    assert_response :success
    
    # Assert we're on the articles page
    assert_equal articles_path, path
    
    # Check for the welcome flash message
    assert_select ".alert-success", text: /Welcome to the Alpha Blog testuser!/
    
    # Check that we're on the articles index page
    assert_select "h1", text: "Articles"
    
    # Verify user is logged in by checking for "Create New Article" button
    assert_select "a[href='#{new_article_path}']", text: "Create New Article"
  end
end
