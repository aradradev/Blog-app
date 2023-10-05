class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments
  has_many :likes
  has_one_attached :photo
  before_create :recent_posts

  before_destroy :delete_user_posts

  def delete_user_posts
    posts.destroy_all
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
