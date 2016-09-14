require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  def setup
    @user = users(:one)
  end
  
  # test the Post index page display.
   test "post index display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: "Posts by "+@user.name
    #We could also test pagination

  end
end


