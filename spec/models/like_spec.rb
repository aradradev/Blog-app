require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with valid attribute' do
    user = User.create(name: 'John')
    Post.create(author: user, title: 'Sample title', text: 'Sample text')
    like = Like.create(user_id: 1, post_id: 1)
    expect(like).to be_valid
  end

  it 'is not valid when the user_id is not an integer' do
    like = Like.create(user_id: 'not integer', post_id: 1)
    expect(like).to_not be_valid
  end
  it 'is not valid when the post_id is not an integer' do
    like = Like.create(user_id: 1, post_id: 'not integer')
    expect(like).to_not be_valid
  end

  it 'updates post likes counter' do
    user = User.create(name: 'jalloh')
    post = Post.create(author: user, title: 'Sample Post', text: 'Sample text')
    Like.create(user_id: user.id, post_id: post.id)
    post.reload
    expect(post.likes_counter).to eq(1)
  end
end
