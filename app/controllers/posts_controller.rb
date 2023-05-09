class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params['id'], user_id: params['user_id'])
  end
end
