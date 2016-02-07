# PostTopFetcher service object
class PostTopFetcher
  def initialize(amount)
    @amount = amount
  end

  def call
    response = { response: { data: [] } }
    averages = Rating.group(:post_id)
                     .average(:score)
                     .to_a
                     .sort { |a, b| b[1] <=> a[1] }[0..@amount]

    averages[0..(@amount-1)].each do |avg|
      post = Post.find(avg[0])
      response[:response][:data] << {
        type: 'posts',
        id: avg[0],
        attributes: {
          title: post.title,
          content: post.content,
          average: post.ratings.average(:score).to_f.round(2)
        }
      }
    end
    response[:status] = :ok
    response
  end
end
