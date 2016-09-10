require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user=users(:one)
  end
  
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session:{email:"",password:""}
    assert_template 'sessions/new'
    #Test for the presence of the error messages
    assert_not flash.empty?
    #Test for error messages disappearance when requesting new page
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information and then logout" do
    #Is it necessary to test it twice?
    get login_path
    assert_template 'sessions/new'
    assert_select "a[href=?]", login_path, count: 1
    post login_path, session:{email:@user.email,password:"password"}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # Check that the login link disappears while the logout appears
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    # Log out
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0
    
  end
end
