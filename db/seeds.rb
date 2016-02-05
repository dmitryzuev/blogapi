# This file should contain all the record creation needed to seed the
# database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside
# the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'factory_girl'
require 'ffaker'
require 'json'
require 'net/http'

usernames = []
ips = []
posts = []
ratings = []

# Generate usernames
100.times do
  usernames << FFaker::Internet.user_name
end

# Generate ips
50.times do
  ips << FFaker::Internet.ip_v4_address
end

# Generate posts
uri = URI('http://localhost:3000/posts')
200000.times do
  post = {
    data: {
      type: "posts",
      attributes: {
        title: FFaker::Lorem.phrase,
        content: FFaker::Lorem.paragraph,
        username: usernames.sample,
        ip: ips.sample
      }
    }
  }

  req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' => 'application/vnd.api+json'})
  req.body = JSON.generate(post)
  res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    http.request(req)
  end
end
