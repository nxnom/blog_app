class CommentsController < ApplicationController
  def create
    @comment = Comment.create(
      user_id: current_user.id,
      post_id: params['id'],
      text: params['text']
    )

    post = Post.find_by(id: params['id'])

    redirect_to user_post_path(post.author_id, post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
