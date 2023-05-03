class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  class << self
    def update_likes_counter(post_id)
      post = Post.find(post_id)
      post.update(likes_counter: post.likes.count)
    end
  end
end
