class IpsController < ApplicationController
  def index
    # sql = "
    #   SELECT *
    #   FROM (
    #     SELECT posts.ip,
    #            COUNT(DISTINCT posts.user_id) as authors
    #     FROM posts
    #     GROUP BY posts.ip
    #   ) d
    #   WHERE d.authors > 1
    #   ORDER BY d.authors DESC;"

    sql = "SELECT posts.ip, COUNT(user_id) FROM posts GROUP BY posts.ip HAVING COUNT(posts.user_id) > 1"

    response = { data: [] }

    ActiveRecord::Base.connection.execute(sql).values.each do |rec|
      response[:data] << {
        type: 'ips',
        id: rec[0],
        attributes: {
          authors: User.find(Post.where(ip: rec[0]).pluck(:user_id)).map { |m| m.username }
        }
      }
    end

    respond_to do |format|
      format.json { render json: response, status: :ok }
    end
  end
end
