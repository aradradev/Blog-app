require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/comments/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/comments/create'
      expect(response).to have_http_status(:success)
    end
  end
end
