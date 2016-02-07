class IpReport < ActiveRecord::Base
  self.table_name = 'mv_ips_report'

  def self.refresh
    connection.execute "REFRESH MATERIALIZED VIEW #{table_name}"
  end

  def readonly?
    true
  end
end
