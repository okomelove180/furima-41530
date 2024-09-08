class Item < ApplicationRecord
  # Associations
  belongs_to :user
  has_one_attached :image

  # Validations
  validates :user_id, presence: true
  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :product_condition_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_cost_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_time_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range (¥300~¥9,999,999)' }
  validates :image, presence: true

  # ActiveHash Associations
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, class_name: 'CategoryGenre'
  belongs_to :product_condition, class_name: 'ProductConditionGenre'
  belongs_to :shipping_cost, class_name: 'ShippingCostGenre'
  belongs_to :prefecture, class_name: 'PrefectureGenre'
  belongs_to :delivery_time, class_name: 'DeliveryTimeGenre'
end
