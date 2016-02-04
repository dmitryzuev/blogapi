class PostsController < ApplicationController
  def create
    response = {test: 'atata'}
    respond_to do |format|
      format.jsonapi { render json: response, status: :created }
    end
  end
end
