require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    
    # Invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, post: { content: "" }
    end
    
    # Valid submission
    content = "Correct_content"
    assert_difference 'Post.count', 1 do
      post posts_path, post: { content: content }
    end
    assert_redirected_to user_url(@user)
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_post = @user.posts.first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit a different user.
    get user_path(users(:two))
    assert_select 'a', text: 'delete', count: 0
  end
end
