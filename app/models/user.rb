class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :likes

  class << self
    def recent_posts(id)
      Post.where(author_id: id).order(created_at: :desc).limit(3)
    end
  end
end
