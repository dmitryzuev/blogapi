require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:rating) { FactoryGirl.create(:rating) }
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
  let(:rating_request) do
    {
      type: 'ratings',
      attributes: {
        score: rand(1..5)
      }
    }
  end

  describe 'GET #top' do
    it 'has application/vnd.api+json content-type' do
      get :top, amount: 5, format: :json
      expect(response.header['Content-Type']).to include('application/vnd.api+json')
    end

    it 'responds successfully with an HTTP 200 status code' do
      get :top, amount: 5, format: :json
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'responds with valid response' do
      rating
      get :top, amount: 5, format: :json

      valid_response = {
        data: [
          {
            type: 'posts',
            id: rating.post.id,
            attributes: {
              title: rating.post.title,
              content: rating.post.content,
              average: rating.score.to_f
            }
          }
        ]
      }

      expect(response.body).to eq(valid_response.to_json)
    end
  end

  describe 'POST #create' do

    it 'has application/vnd.api+json content-type' do
      post :create, format: :json, data: post_request
      expect(response.header['Content-Type']).to include('application/vnd.api+json')
    end

    it 'responds with 201 status after creation' do
      post :create, format: :json, data: post_request
      expect(response).to have_http_status(201)
    end

    it 'responds with valid data after creation' do
      post :create, format: :json, data: post_request

      last_post = Post.last
      valid_response = {
        data: {
          type: 'posts',
          id: last_post.id,
          attributes: {
            title: last_post.title,
            username: last_post.username,
            ip: last_post.ip
          }
        }
      }

      expect(response.body).to eq(valid_response.to_json)
    end

    it 'responds with 422 status after wrong data'
    it 'responds with errors after failure'
  end

  describe 'POST #rate' do
    it 'has application/vnd.api+json content-type' do
      rating
      post :rate, id: rating.post_id, format: :json, data: rating_request
      expect(response.header['Content-Type']).to include('application/vnd.api+json')
    end

    it 'responds with 201 status after creation' do
      rating
      post :rate, id: rating.post_id, format: :json, data: rating_request
      expect(response).to have_http_status(201)
    end

    it 'responds with 422 status after wrong data' do
      rating_request[:attributes][:score] = 10
      post :rate, id: rating.post_id, format: :json, data: rating_request
      expect(response).to have_http_status(422)
    end

    it 'responds with valid data after creation' do
      rating
      post :rate, id: rating.post_id, format: :json, data: rating_request

      valid_response = {
        data: {
          type: 'ratings',
          attributes: {
            post_id: rating.post_id,
            average: rating.post.ratings.average(:score).to_f.round(2)
          }
        }
      }

      expect(response.body).to eq(valid_response.to_json)
    end

    it 'responds with errors after failure'
  end
end
