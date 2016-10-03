require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end
    

  test "successful edit" do
    log_in_as(@user, password:@user.password)
    get user_edit_url(@user.name)
    assert_template 'users/edit'
    name="Test1"
    email="test@valid.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }

    @user.reload
    assert_redirected_to @user
    
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
  
  test "unsuccessful edit" do
    log_in_as(@user, password:@user.password)
    get user_edit_url(@user.name)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "test@invalid",
                                              password:              "123",
                                              password_confirmation: "456" } }
                                              

    assert_template 'users/edit'
  end
  
end
