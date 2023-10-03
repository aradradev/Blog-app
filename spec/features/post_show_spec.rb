require 'rails_helper'

RSpec.describe 'Post show method', type: :feature do
  before(:example) do
    @user = User.create(
      name: 'Moha',
      photo: 'https://images.unsplash.com/photo-1594897030264-ab7d87efc473?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
      bio: 'Teacher from Yemen.',
      posts_counter: 8
    )

    @posts = [
      Post.create(
        author: @user,
        title: 'Hi',
        text: 'This is first post',
        comments_counter: 0,
        likes_counter: 0
      ),
      Post.create(
        author: @user,
        title: 'Hey',
        text: 'This is second post',
        comments_counter: 0,
        likes_counter: 0
      ),
      Post.create(
        author: @user,
        title: "What's up",
        text: 'This is third post',
        comments_counter: 0,
        likes_counter: 0
      )
    ]

    @comments = [
      Comment.create(user: @user, post: @posts[0], text: 'Hi Tom!'),
      Comment.create(user: @user, post: @posts[0], text: 'How are you'),
      Comment.create(user: @user, post: @posts[1], text: 'What are you doing tonight')
    ]
    @post = @posts.first
    visit post_path(@post)
  end


  it 'displays the post title' do
    expect(page).to have_content(@post.title)
  end

  it 'displays who wrote the post' do
    expect(page).to have_content("by #{@user.name}")
  end

  it 'displays how many comments it has' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'displays how many likes it has' do
    expect(page).to have_content('Likes: 0')
  end

  it 'displays the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'displays the username of each commentor' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'displays the comment each commentor left' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'displays a comment form' do
    expect(page).to have_css('form[action*="comments"]')
  end

  it 'displays a like button' do
    expect(page).to have_css('form#new_like')
  end
end
