class CommentsController < ApplicationController
  def create
    Comment.create(
      user_id: current_user.id,
      post_id: params['post_id'],
      text: params['text']
    )

    refresh
  end

  def destroy
    load_and_authorize_resource

    comment = Comment.destroy(params['id'])

    comment.post.update_comments_counter

    refresh
  end

  private

  def refresh
    post = Post.find_by(id: params['post_id'])

    respond_to do |format|
      format.html { redirect_to user_post_path(post.author_id, post) }
      format.json { head :no_content }
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
