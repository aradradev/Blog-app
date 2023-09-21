class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true, numericality: { only_integer: true }

  validates :post_id, presence: true, numericality: { only_integer: true }
  before_create :update_post_likes_counter

  private

  def update_post_likes_counter
    post.update(likes_counter: post.likes.count + 1)
  end
end
