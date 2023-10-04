require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
  before(:example) do
    @user = User.create(
      name: 'Jalloh',
      photo: 'https://images.unsplash.com/photo-1594897030264-ab7d87efc473?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
      bio: 'Software Engineer.',
      posts_counter: 3
    )

    @posts = [
      Post.create(
        author: @user,
        title: 'Hi',
        text: 'This is first post',
        comments_counter: 2,
        likes_counter: 0
      ),
      Post.create(
        author: @user,
        title: 'Hey',
        text: 'This is second post',
        comments_counter: 1,
        likes_counter: 0
      ),
      Post.create(
        author: @user,
        title: "What's up",
        text: 'This is third post',
        comments_counter: 3,
        likes_counter: 0
      )
    ]

    @comments = [
      Comment.create(user: @user, post: @posts[0], text: 'Hi Tom!'),
      Comment.create(user: @user, post: @posts[0], text: 'How are you'),
      Comment.create(user: @user, post: @posts[1], text: 'What are you doing tonight')
    ]
    @post_counter = @user.posts.count
    visit posts_path(user_id: @user.id)
  end

  it 'displays the user profile picture' do
    expect(page).to have_css('.user-profile')
  end

  it 'displays the user username' do
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content("#{@post_counter} Posts")
  end

  it 'displays a post title' do
    expect(page).to have_content(@posts.first.title)
  end

  it 'displays some of the post body' do
    expect(page).to have_content(@posts.first.text[0..149])
  end

  it 'displays the first comments on a post' do
    expect(page).to have_content(@comments.first.text)
  end

  it 'displays how many comments a post has' do
    expect(page).to have_content("Comments: #{@posts.first.comments_counter}")
  end

  it 'displays how many likes a post has' do
    expect(page).to have_content("Likes: #{@posts.first.likes_counter}")
  end

  it 'displays a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_css('.btn-paginate')
  end

  it 'redirects to the post show page when clicking on a post' do
    visit post_path(@posts.first)
    expect(page).to have_current_path(post_path(@posts.first))
  end
end
