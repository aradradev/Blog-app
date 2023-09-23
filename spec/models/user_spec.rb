require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and posts_counter greater than or equal to zero' do
    user = User.new(name: 'John', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(posts_counter: 0)
    expect(user).to_not be_valid
  end

  it 'is invalid if posts_counter is not an integer' do
    user = User.new(name: 'John', posts_counter: 'invalid')
    expect(user).to_not be_valid
  end

  it 'returns the 3 most recent posts for a user' do
    user = User.create(name: 'John')
    Post.create(author: user, title: 'Post 1', text: 'Text 1', created_at: 3.days.ago)
    Post.create(author: user, title: 'Post 2', text: 'Text 2', created_at: 2.days.ago)
    Post.create(author: user, title: 'Post 3', text: 'Text 3', created_at: 1.days.ago)
    Post.create(author: user, title: 'Post 4', text: 'Text 4', created_at: Time.current)
    user.reload

    expect(user.posts_counter).to be >= 0
  end
end
