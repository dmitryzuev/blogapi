class IpsController < ApplicationController
  def index
    response = { data: [] }

    ips = {}
    IpUsername.select(:ip, :username)
              .where('ip IN (
                         SELECT ip
                         FROM ip_usernames
                         GROUP BY ip
                         HAVING COUNT(username) > 1
                      )')
              .pluck(:ip, :username).each do |row|
      if ips[row[0]]
        ips[row[0]] << row[1]
      else
        ips[row[0]] = [row[1]]
      end
    end

    respond_to do |format|
      format.json { render json: ips, status: :ok }
    end
  end
end
