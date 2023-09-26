require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET /index' do
    it 'renders with 200 OK status' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'Get /show' do
    it 'responds the post show with 200 OK status' do
      user = User.create(name: 'jalloh')
      post = Post.create(author: user, title: 'Sample title', text: 'Sample text')
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct template show' do
      user = User.create(name: 'Doe')
      post = Post.create(author: user, title: 'Hello', text: 'Sample text')
      get :show, params: { id: post.id }
      expect(response).to render_template(:show)
    end
  end
end
