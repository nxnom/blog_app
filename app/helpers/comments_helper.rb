module CommentsHelper
  def can_destroy_comment?(comment)
    return false unless user_signed_in?

    current_user.admin? || comment.user == current_user
  end
end
