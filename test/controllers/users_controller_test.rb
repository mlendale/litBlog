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
    get :edit
    assert_response :success
  end

  test "should get show" do
    get :show, id:@user
    assert_response :success
  end

end
