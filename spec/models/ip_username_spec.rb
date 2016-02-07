require 'rails_helper'

RSpec.describe IpUsername, type: :model do
  let(:ip_username) { FactoryGirl.build(:ip_username) }
  let(:ip_username_double) { FactoryGirl.build(:ip_username) }
  let(:ip_username_without_username) { FactoryGirl.build(:ip_username_without_username) }
  let(:ip_username_without_ip) { FactoryGirl.build(:ip_username_without_ip) }

  it 'has valid factory' do
    expect(ip_username).to be_valid
  end

  it 'is invalid without username' do
    expect(ip_username_without_username).not_to be_valid
  end

  it 'is invalid without ip' do
    expect(ip_username_without_ip).not_to be_valid
  end

  it 'has uniq pairs of ip and username' do
    ip_username.save!
    expect(ip_username_double).not_to be_valid
  end
end
