require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'responds with 200 OK status' do
      get '/posts'
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get '/posts'
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in response body' do
      get '/posts'
      expect(response.body).to include('This is a placeholder for posts index content.')
    end
  end

  describe 'GET /posts/:id' do
    it 'responds the post show with 200 OK status' do
      user = User.create(name: 'jalloh')
      post = Post.create(author: user, title: 'Sample title', text: 'Sample text')
      get "/posts/#{post.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct template show' do
      user = User.create(name: 'Doe')
      post = Post.create(author: user, title: 'Hello', text: 'Sample text')
      get "/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text show in response body' do
      user = User.create(name: 'Doe')
      post = Post.create(author: user, title: 'Sample title', text: 'Sample text')
      get "/posts/#{post.id}"
      expect(response.body).to include('Sample title')  
      expect(response.body).to include('Sample text')
      expect(response.body).to include('Author: Doe')
      expect(response.body).to include('Comments: 0')
      expect(response.body).to include('Likes: 0')
    end
  end
end
