require 'rails_helper'
require 'spec_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Tom', posts_counter: 0)}
  it 'is valid with title, comments_counter and likes_counter greater than or equal to 0' do
    post = Post.new(author: user, title: 'Sample Title', comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is invalid without a comments_counter' do
    post = Post.new(author: user, title: 'Hello', comments_counter: nil, likes_counter: 0)
    expect(post).to_not be_valid
  end
  it 'is invalid without a likes_counter' do
    post = Post.new(author: user, title: 'Hello', comments_counter: 0, likes_counter: nil)
    expect(post).to_not be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(author: user, title: nil, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is valid if the title is under 250 characters' do
    title1='a'*39;
    post = Post.new(author: user, title: title1, comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end
  it 'is invalid if the title exceeds 250 characters' do
    title2='a'*251;
    post = Post.new(author: user, title: title2, comments_counter: 0, likes_counter: 0)
    expect(post).to_not be_valid
  end

  it 'is invalid if comments counter is not an integer' do
    post = Post.new(author: user, title: 'Sample title', comments_counter: 'invalid', likes_counter: 0)
    expect(post).to_not be_valid
  end
  it 'is invalid if likes counter is not an integer' do
    post = Post.new(author: user, title: 'Sample title', comments_counter: 0, likes_counter: 'invalid')
    expect(post).to_not be_valid
  end
end
