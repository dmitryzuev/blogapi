# PostsController API
class PostsController < ApplicationController
  def create
    post = Post.new(post_params['attributes'])

    respond_to do |format|
      if post.save
        response = {
          data: {
            type: 'posts',
            id: post.id,
            attributes: {
              title: post.title,
              username: post.username,
              ip: post.ip
            }
          }
        }
        format.json { render json: response, status: :created }
      else
        errors = []
        post.errors.messages.each do |key, error|
          errors << { status: 422, code: key, title: error[0] }
        end

        format.json { render json: { errors: errors }, status: :unprocessable_entity }
      end
    end
  end

  def rate
    post = Post.find(params[:id])
    rating = Rating.new(rating_params['attributes'].merge('post' => post))

    respond_to do |format|
      if rating.save
        response = {
          data: {
            type: 'ratings',
            attributes: {
              post_id: post.id,
              average: post.ratings.average(:score).to_f.round(2)
            }
          }
        }

        format.json { render json: response, status: :created }
      else
        errors = []
        rating.errors.messages.each do |key, error|
          errors << { status: 422, code: key, title: error[0] }
        end
        format.json { render json: { errors: errors }, status: :unprocessable_entity }
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
