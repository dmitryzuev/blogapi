require 'rails_helper'

RSpec.describe IpsController, type: :controller do
  let(:post_params) do
    {
      title: FFaker::Lorem.phrase,
      content: FFaker::Lorem.paragraph,
      username: FFaker::Internet.user_name,
      ip: FFaker::Internet.ip_v4_address
    }
  end
  let(:post_request) do
    {
      type: 'posts',
      attributes: {
        title: FFaker::Lorem.phrase,
        content: FFaker::Lorem.paragraph,
        username: FFaker::Internet.user_name,
        ip: FFaker::Internet.ip_v4_address
      }
    }
  end

  describe 'GET #index' do
    it 'has application/vnd.api+json content-type' do
      get :index, format: :json
      expect(response.header['Content-Type']).to include('application/vnd.api+json')
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :index, format: :json
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'responds with valid response' do
      posts = []
      posts << PostCreator.new(post_params).call
      post_params[:ip] = Post.last.ip
      post_params[:username] = FFaker::Internet.user_name
      posts << PostCreator.new(post_params).call
      post_params[:ip] = Post.last.ip
      post_params[:username] = FFaker::Internet.user_name
      posts << PostCreator.new(post_params).call

      get :index, format: :json

      valid_response = {
        data: [{
          type: 'ips',
          id: Post.last.ip,
          attributes: {
            authors: [
              posts[0][:response][:data][:attributes][:username],
              posts[1][:response][:data][:attributes][:username],
              posts[2][:response][:data][:attributes][:username]
            ]
          }
        }]
      }

      expect(response.body).to eq(valid_response.to_json)
    end
  end
end
