require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user= users(:one)
    @second_user = users(:two)
    @post1=posts(:post1_byone)
    @post2 = posts(:post2_bytwo)
  end
  
  test "Create should be redirected to login_path when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "Create should be redirected to user/show" do
    post login_path, session: { email: @user.email, password: 'password' }
    #post=posts(:post1_byone)
    assert_redirected_to user_path(@user)
  end

  test "Edit should be redirected to login_path when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end
  
  test "Edit should be redirected to login when logged in as the wrong user" do
    log_in_as(@user)
    #post = posts(:post2_bytwo)
    get edit_post_url(@post2)
    post edit_post_url(@post2), params: { post: { content: "Lorem ipsum" }}
    assert_redirected_to login_url
  end
  
  test "Update should be redirected to login when logged in as the wrong user" do
    log_in_as(@user)
    #post = posts(:post2_bytwo)
    get edit_post_url(@post2)
    patch update_post_url(@post2), post: { content: "blabla" }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
end
