require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user= users(:one)
  end
  
  test "Create should be redirected to login_path when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "Create should be redirected to user/show" do
    post login_path, session: { email: @user.email, password: 'password' }
    post=posts(:post1)
    assert_redirected_to user_path(@user)
  end

end
