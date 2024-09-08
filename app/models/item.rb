class Item < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :category_id, presence: true
  validates :product_condition_id, presence: true
  validates :shipping_cost_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_time_id, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000 }
end
