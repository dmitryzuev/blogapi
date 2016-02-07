# PostsController API
class PostsController < ApplicationController
  def create
    res = PostCreator.new(post_params['attributes']).call

    respond_to do |format|
      format.json { render json: res[:response], status: res[:status] }
    end
  end

  def rate
    res = PostRater.new(
      rating_params['attributes'].merge('post_id' => params[:id])
    ).call

    respond_to do |format|
      format.json { render json: res[:response], status: res[:status] }
    end
  end

  def top
    res = PostTopFetcher.new(params[:amount].to_i).call

    respond_to do |format|
      format.json { render json: res[:response], status: res[:status] }
    end
  end

  private

  def post_params
    params.require(:data)
          .permit(:type, attributes: [:title, :content, :username, :ip])
  end

  def rating_params
    params.require(:data)
          .permit(:type, attributes: [:score])
  end
end
