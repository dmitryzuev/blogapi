class CreateIpReportMv < ActiveRecord::Migration
  def up
    connection.execute <<-SQL
      CREATE MATERIALIZED VIEW mv_ips_report AS
        SELECT p1.ip as ip,
               u.username as username
        FROM posts p1
        INNER JOIN users u ON p1.user_id = u.id
        WHERE p1.ip IN (
          SELECT p2.ip
          FROM posts p2
          GROUP BY p2.ip
          HAVING COUNT(p2.user_id) > 1
        )
        GROUP BY p1.ip, u.username;
      CREATE INDEX ON mv_ips_report (ip, username);
    SQL
  end

  def down
    connection.execute <<-SQL
      DROP MATERIALIZED VIEW IF EXISTS mv_ips_report;
    SQL
  end
end
