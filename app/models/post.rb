class Post < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
  validates :ip, presence: true

  def username=(var)
    self.user = User.find_or_create_by(username: var)
  end

  def username
    user.username
  end
end
