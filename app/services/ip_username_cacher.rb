# Service object for caching ip and username
class IpUsernameCacher
  def call(ip, username)
    IpUsername.find_or_create_by(ip: ip, username: username)
  end

  def rebuild
    IpUsername.delete_all
    Post.joins(:user).each do |post|
      self.call(post.ip, post.username)
    end
  end
end
