# PostCreator service object
class PostCreator
  def initialize(params)
    @params = params
  end

  def call
    # TODO: Check input params
    response = { response: {} }
    post = Post.new(@params)

    if post.save
      # Don't forget to cache this ip
      IpUsernameCacher.new.call(@params[:ip], @params[:username])
      response[:response] = {
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
      response[:status] = :created
    else
      response[:response][:errors] = []
      post.errors.messages.each do |key, error|
        response[:response][:errors] << {
          status: 422, code: key, title: error[0]
        }
      end
      response[:status] = :unprocessable_entity
    end

    # TODO: return feature-rich object
    response
  end
end
