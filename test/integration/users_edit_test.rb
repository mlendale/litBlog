require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user=users(:one)
  end
    
  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "test@invalid",
                                              password:              "123",
                                              password_confirmation: "456" } }

    assert_template 'users/edit'
  end
  
  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name="Test1"
    email="test@valid.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }

    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
