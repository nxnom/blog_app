module PostsHelper
  def get_comments(post:, is_post_view: false, show_comments: nil)
    return [] unless show_comments

    is_post_view ? post.comments : post.recent_comments
  end

  def can_destroy_post?(post)
    return false unless user_signed_in?

    current_user.admin? || post.user == current_user
  end
end
