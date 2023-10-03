require 'rails_helper'

RSpec.describe 'User show method ', type: :feature do
  # rubocop:disable Layout/LineLength
  before(:example) do
    @user = User.create(name: 'Jalloh',
                        photo: 'https://images.unsplash.com/photo-1594897030264-ab7d87efc473?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
                        bio: 'Teacher from Ghini.', posts_counter: 5)

    @posts = [Post.create(author: @user, title: 'Hello', text: 'This is first post', likes_counter: 0,
                          comments_counter: 0),
              Post.create(author: @user, title: 'Hi', text: 'This is second post', likes_counter: 0,
                          comments_counter: 0),
              Post.create(author: @user, title: 'What"s up', text: 'This is third post', likes_counter: 0,
                          comments_counter: 0)]

    @comments = [
      Comment.create(user: @user, post: @posts[0], text: 'Hi Tom!'),
      Comment.create(user: @user, post: @posts[0], text: 'How are you'),
      Comment.create(user: @user, post: @posts[1], text: 'What are you doing tonight')
    ]
    # rubocop:enable Layout/LineLength
    
    
    # you can edit this line
    # visit user_posts_path(@user, @posts)
  end

  it 'shows the user\'s profile picture' do
    expect(page.html).to include('user-profile')
    find("img[src='#{@user.photo}']")
  end

  it 'shows the name of username' do
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts' do
    expect(page).to have_content(@user.posts.count)
  end

  it 'shows a post title' do
    @posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'shows a post text' do
    @posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'shows recent comments' do
    @posts[0].recent_comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'shows a comments count' do
    expect(page).to have_content(@posts[0].comments_counter)
  end

  it 'shows a comments count' do
    expect(page).to have_content(@posts[0].likes_counter)
  end

  it 'shows the paginate button' do
    expect(page).to have_content('Paginate')
  end

#   it 'redirects me to the post page' do
#     post = @posts.first
#     click_link(post.title)
#     expect(page).to have_current_path(user_post_path(@user, post))
#   end
end