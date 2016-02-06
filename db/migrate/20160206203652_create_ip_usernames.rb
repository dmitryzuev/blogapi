class CreateIpUsernames < ActiveRecord::Migration
  def change
    create_table :ip_usernames do |t|
      t.string :ip
      t.string :username
    end
    add_index :ip_usernames, [:ip, :username], unique: true
  end
end
