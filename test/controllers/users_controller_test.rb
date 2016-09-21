require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, name:@user.name
    assert_response :success
  end

  test "should get show" do
    get :show, name:@user.name
    assert_response :success
  end
  
  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end


end
