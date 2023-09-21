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
end
