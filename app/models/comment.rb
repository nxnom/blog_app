class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  class << self
    def update_comments_counter(post_id)
      post = Post.find(post_id)
      post.update(comments_counter: post.comments.count)
    end
  end
end
