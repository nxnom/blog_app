class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id

  has_many :comments
  has_many :likes

  class << self
    def recent_comments(post_id)
      Comment.where(post_id:).order(created_at: :desc).limit(5)
    end

    def update_posts_counter(user_id)
      user = User.find(user_id)
      user.update(posts_counter: user.posts.count)
    end
  end
end
