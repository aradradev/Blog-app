require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attribute' do
    user = User.create(name: 'Jalloh')
    post = Post.create(author: user, title: 'Sample title', text: 'Sample text')
    comment = Comment.create(user:, post:, text: 'This is valid comment')
    expect(comment).to be_valid
  end
  it 'is not valid when the user_id is not an integer' do
    comment = Comment.create(user_id: 'not integer', post_id: 1, text: 'invalid comment')
    expect(comment).to_not be_valid
  end

  it 'is not valid to when the post_id is not an integer' do
    comment = Comment.create(user_id: 1, post_id: 'not integer', text: 'invalid comment')
    expect(comment).to_not be_valid
  end

  it 'updates post comments counter' do
    user = User.create(name: 'jalloh')
    post = Post.create(author: user, title: 'Sample Post', text: 'Sample text')
    Comment.create(user_id: user.id, post_id: post.id, text: 'Valid comment')
    post.reload
    expect(post.comments_counter).to eq(1)
  end
end
