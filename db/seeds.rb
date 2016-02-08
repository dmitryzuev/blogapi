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

# Generate usernames
100.times do
  usernames << FFaker::Internet.user_name
end

# Generate ips
50.times do
  ips << FFaker::Internet.ip_v4_address
end

if Rails.env == 'development'
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

  # Generate ratings
  1000.times do
    rating = {
      data: {
        type: 'ratings',
        attributes: {
          score: rand(1..5)
        }
      }
    }
    uri = URI("http://localhost:3000/posts/#{rand(100000..100500)}/rate")
    req = Net::HTTP::Post.new(uri, initheader = {'Content-Type' => 'application/vnd.api+json'})
    req.body = JSON.generate(rating)
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end

# For test purposes we don't need http requests
elsif Rails.env == 'test'

  # Seed with posts
  2000.times do
    post_data = {
      title: FFaker::Lorem.phrase,
      content: FFaker::Lorem.paragraph,
      username: usernames.sample,
      ip: ips.sample
    }

    PostCreator.new(post_data).call
  end

  # Seed with ratings
  100.times do
    rating_data = {
      post_id: rand(100000..100500),
      score: rand(1..5)
    }

    PostRater.new(rating_data).call
  end
end
