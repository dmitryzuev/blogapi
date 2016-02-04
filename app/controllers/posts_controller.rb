# PostsController API
class PostsController < ApplicationController
  def create
    post = Post.new(post_params['attributes'])

    respond_to do |format|
      if post.save
        format.json { render json: post, status: :created }
      else
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def rate
    post = Post.find(params[:id])
    rating = Rating.new(rating_params['attributes'].merge({'post' => post}))

    respond_to do |format|
      if rating.save
        format.json { render json: rating, status: :created }
      else
        format.json { render json: rating.errors, status: :unprocessable_entity }
      end
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
