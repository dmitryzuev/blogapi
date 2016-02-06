class IpsController < ApplicationController
  def index
    response = { data: [] }

    data = IpUsername.select(:ip, :username)
                     .where('ip IN (
                               SELECT ip
                               FROM ip_usernames
                               GROUP BY ip
                               HAVING COUNT(username) > 1
                             )').each do |row|
      if x = response[:data].index { |x| x[:id] }
        response[:data][x][:attributes][:authors] << row.username
      else
        response[:data] << {
          type: 'ips',
          id: row.ip,
          attributes: {
            authors: [row.username]
          }
        }
      end
    end

    respond_to do |format|
      format.json { render json: response, status: :ok }
    end
  end
end
