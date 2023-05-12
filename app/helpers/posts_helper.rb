module PostsHelper
  def get_comments(post:, is_post_view: false, show_comments: nil)
    return [] unless show_comments

    is_post_view ? post.comments : post.recent_comments
  end
end
