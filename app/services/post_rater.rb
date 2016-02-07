# PostRater service object
class PostRater
  def initialize(params)
    @params = params
    @params[:post] = Post.where(id: @params[:post_id]).first
  end

  def call
    # TODO: Check input params
    response = { response: {} }
    rating = Rating.new(@params)

    if rating.save
      response[:response] = {
        data: {
          type: 'ratings',
          attributes: {
            post_id: rating.post_id,
            average: rating.post.ratings.average(:score).to_f.round(2)
          }
        }
      }
      response[:status] = :created
    else
      response[:response][:errors] = []
      rating.errors.messages.each do |key, error|
        response[:response][:errors] << { status: 422, code: key, title: error[0] }
      end
      response[:status] = :unprocessable_entity
    end

    # TODO: Return feature-rich object
    response
  end

end
