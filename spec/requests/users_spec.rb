require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'responds with 200 OK' do
      get '/users'
      expect(response).to have_http_status(:ok)
    end

    it 'should render the index template Users correctly' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'should include the correct placeholder text index' do
      get '/users'
      expect(response.body).to include('Welcome to my Blog app!')
      expect(response.body).to include('User1: John Doe.')
    end
  end

  describe 'GET /users:id' do
    it 'should responds with 200 OK' do
      user = User.create(name: 'Tommy', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to have_http_status(:ok)
    end
    it 'should renders correct placeholder text show' do
      user = User.create(name: 'John')
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'should includes correct information and render properly from the show' do
      user = User.create(name: 'Jalloh', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response.body).to include('Jalloh')
      expect(response.body).to include('Posts: 0')
    end
  end
end
