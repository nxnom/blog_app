class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id

  has_many :comments
  has_many :likes

  after_save :update_posts_counter

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(3)
  end

  def update_posts_counter
    user = User.find(author_id)
    user.update(posts_counter: user.posts.count)
  end
end
