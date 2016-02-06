class IpUsername < ActiveRecord::Base
  validates :ip, presence: true, uniqueness: {scope: :username}
  validates :username, presence: true
end
