require 'rails_helper'

RSpec.describe 'User show method ', type: :feature do
  # rubocop:disable Layout/LineLength
  before(:example) do
    @user = User.create(name: 'Jalloh',
                        photo: 'https://images.unsplash.com/photo-1594897030264-ab7d87efc473?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
                        bio: 'Teacher from Ghini.', posts_counter: 5)

    @posts = [Post.create(author: @user, title: 'Hi', text: 'This is first post', likes_counter: 0,
                          comments_counter: 0),
              Post.create(author: @user, title: 'Hi', text: 'This is second post', likes_counter: 0,
                          comments_counter: 0),
              Post.create(author: @user, title: 'What\'s up', text: 'This is third post', likes_counter: 0,
                          comments_counter: 0)]
    # rubocop:enable Layout/LineLength
    visit user_path(@user)
  end

  it 'shows the user\'s profile' do
    expect(page.html).to include('user-profile')
    find("img[src='#{@user.photo}']")
  end

  it 'shows the name of user' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the user\'s bio' do
    expect(page).to have_content(@user.bio)
  end

  it 'show the number of posts' do
    expect(page).to have_content(@user.posts.count)
  end

  it 'shows the first three posts' do
    @posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

#   it 'shows the "view all posts" button' do
#     find_button('View all')
#   end

  #   it 'redirects me to that post's show page' do
  #     click_link('See all Posts')
  #     expect(page).to have_current_path(user_posts_path(@user))
  #   end

end