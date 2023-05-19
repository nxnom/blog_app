class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_defaults

  def set_defaults
    self.posts_counter ||= 0
    self.name ||= email.split('@').first || 'Anonymous'
    self.photo ||= 'https://media.istockphoto.com/vectors/profile-placeholder-image-gray-silhouette-no-photo-vector-id1016744004?k=6&m=1016744004&s=612x612&w=0&h=L-6pLRmsCm-LHeaC493SSAOSB5ftQB8s3MX87WrktMU='
  end

  def recent_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end

  def admin?
    role == 'admin'
  end
end
