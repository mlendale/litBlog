require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @second_user = users(:two)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get :show, name:@user.name
    assert_response :success
  end
  

  test "should redirect edit when not logged in" do
    get :edit, name:@user.name
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch :update, name: @user.name, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as the wrong user" do
    log_in_as(@user)
    get :edit, name:@second_user.name
    assert_not flash.empty?
    assert_redirected_to user_show_url
  end
  
  test "should redirect update when logged in as the wrong user" do
    log_in_as(@second_user)
    patch :update, name: @second_user.name, user: { name: @second_user.name, email: @second_user.email }
    assert_not flash.empty?
    assert_redirected_to user_show_url
  end


end
