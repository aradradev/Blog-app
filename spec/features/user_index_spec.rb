require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:example) do
    DatabaseCleaner.start
    @users = [
      User.create(
        name: 'User1',
        photo: 'https://photo1.jpg',
        bio: 'Bio for User1',
        posts_counter: 5
      ),
      User.create(
        name: 'User2',
        photo: 'https://photo2.jpg',
        bio: 'Bio for User2',
        posts_counter: 3
      ),
      User.create(
        name: 'User3',
        photo: 'https://photo3.jpg',
        bio: 'Bio for User3',
        posts_counter: 8
      )
    ]

    visit users_path
  end

  after(:example) do
    DatabaseCleaner.clean
  end

  it 'displays the username of all other users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays the profile picture for each user' do
    @users.each do |user|
      expect(page).to have_css(".user-profile[src*='#{user.photo}']")
    end
  end

  it 'displays the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content("#{user.posts.count} post")
    end
  end

  it 'redirects to the user show page when clicking on a user' do
    user = @users.first
    visit user_path(user)
    expect(page).to have_current_path(user_path(user))
  end
end
