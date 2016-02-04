class Post < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  def username=(var)
    self.user = User.find_or_create_by(username: var)
  end

  def username
    user.username
  end
end
