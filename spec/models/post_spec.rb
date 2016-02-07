require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post)                 { FactoryGirl.build(:post) }
  let(:post_without_title)   { FactoryGirl.build(:post_without_title) }
  let(:post_without_content) { FactoryGirl.build(:post_without_content) }
  let(:post_without_user)    { FactoryGirl.build(:post_without_user) }
  let(:post_without_ip)      { FactoryGirl.build(:post_without_ip) }

  it 'has valid factory' do
    expect(post).to be_valid
  end

  it 'is invalid without title' do
    expect(post_without_title).not_to be_valid
  end

  it 'is invalid without content' do
    expect(post_without_content).not_to be_valid
  end

  it 'is invalid without user' do
    expect(post_without_user).not_to be_valid
  end

  it 'is invalid without ip' do
    expect(post_without_ip).not_to be_valid
  end
end
