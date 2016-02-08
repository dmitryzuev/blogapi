require 'rails_helper'

RSpec.describe IpsController, type: :controller do
  if Post.count < 2000
    puts 'Seeding database, please wait'
    load "#{Rails.root}/db/seeds.rb"
    puts 'Seeding completed'
  end

  describe 'GET #index' do
    it 'is performed faster than 100 ms' do
      expect(
        Benchmark.realtime { get :index, :format => :json } * 1000
      ).to be < 100.0
    end
  end
end
