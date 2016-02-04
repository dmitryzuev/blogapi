class Rating < ActiveRecord::Base
  belongs_to :post

  validates :post, presence: true
  validates :score,
            presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than: 6 }
end
