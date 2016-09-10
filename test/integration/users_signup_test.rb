require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path,user: {name:"  ",
        email:"user@none",
        password:"1234",
        password_confirmation:"7895"}
    
    end
    #Test that we are back to the Sign up page
    assert_template "users/new"
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path,user: {name:"Test Test",
        email:"user@test.com",
        password:"123456",
        password_confirmation:"123456"}
      follow_redirect!
    end
    #Test that we are at the user's page
    assert_template "users/show"
    assert is_logged_in?
  end
end
