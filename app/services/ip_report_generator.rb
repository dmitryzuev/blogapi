# IpReportGenerator service object
class IpReportGenerator
  def call
    {
      response: {
        data: ips.to_a.map do |m|
          { type: 'ips', id: m[0], attributes: { authors: m[1] } }
        end
      },
      status: :ok
    }
  end

  private

  # Make ip: [usernames] hash
  def ips
    data = {}
    ip_materialized_query.each do |row|
      if data[row[0]]
        data[row[0]] << row[1]
      else
        data[row[0]] = [row[1]]
      end
    end
    data
  end

  # Perform lookup query from ip/username cache
  def ip_query
    IpUsername.select(:ip, :username)
              .where('ip IN (
                         SELECT ip
                         FROM ip_usernames
                         GROUP BY ip
                         HAVING COUNT(username) > 1
                      )')
              .pluck(:ip, :username)
  end

  def ip_materialized_query
    IpReport.pluck(:ip, :username)
  end
end
