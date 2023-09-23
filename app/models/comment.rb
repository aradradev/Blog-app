class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :post_id, presence: true, numericality: { only_integer: true }
  before_create :update_post_comments_counter

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count + 1)
  end
end
