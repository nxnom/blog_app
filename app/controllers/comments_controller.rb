class CommentsController < ApplicationController
  def index
    @comments = Comment.where(post_id: params['post_id'])
  end

  def create
    @comment = Comment.create(
      user_id: current_user.id,
      post_id: params['post_id'],
      text: params['text']
    )

    post = Post.find_by(id: params['post_id'])

    respond_to do |format|
      format.html { redirect_to user_post_path(post.author_id, post) }
      format.json { render :show, status: :created }
    end
  end

  def destroy
    comment = Comment.destroy(params['id'])

    comment.post.update_comments_counter

    post = Post.find_by(id: params['post_id'])

    respond_to do |format|
      format.html { redirect_to user_post_path(post.author_id, post) }
      format.json { head :no_content }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
