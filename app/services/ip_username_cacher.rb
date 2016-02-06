class IpUsernameCacher
  def call(ip, username)
    IpUsername.find_or_create_by(ip: ip, username: username)
  end

  def rebuild
    Post.joins(:user).each do |post|
      self.call(post.ip, post.username)
    end
  end
end
