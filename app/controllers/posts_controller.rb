# PostsController API
class PostsController < ApplicationController
  def create
    @post = Post.new(post_params['attributes'])

    respond_to do |format|
      if @post.save
        format.json { render json: @post, status: :created }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:data)
          .permit(:type, attributes: [:title, :content, :username, :ip])
  end
end
