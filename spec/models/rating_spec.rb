require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating)               { FactoryGirl.build(:rating) }
  let(:rating_greater)       { FactoryGirl.build(:rating_greater) }
  let(:rating_less)          { FactoryGirl.build(:rating_less) }
  let(:rating_without_post)  { FactoryGirl.build(:rating_without_post) }
  let(:rating_without_score) { FactoryGirl.build(:rating_without_score) }

  it 'has valid factory' do
    expect(rating).to be_valid
  end

  it 'is invalid with rating greater than 5' do
    expect(rating_greater).not_to be_valid
  end

  it 'is invalid with rating less than 1' do
    expect(rating_less).not_to be_valid
  end

  it 'is invalid without post' do
    expect(rating_without_post).not_to be_valid
  end

  it 'is invalid without score' do
    expect(rating_without_score).not_to be_valid
  end
end
