require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET /index' do
    it 'responds with 200 OK' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'Get /show' do
    it 'responds show with 200 OK' do
      user = User.create(name: 'Jalloh', posts_counter: 0)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:ok)
    end

    it 'it renders the show template' do
      user = User.create(name: 'John', posts_counter: 0)
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end
end
