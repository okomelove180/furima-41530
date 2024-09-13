class PurchaseRecordShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :purchase_record_id, :post_code, :prefecture_id, :municipality, :street_address,
                :building_name, :telephone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :municipality
    validates :street_address
  end

  validates :post_code, presence: { message: "can't be blank" },
                        format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  validates :telephone_number, presence: { message: "can't be blank" },
                               format: { with: /\A\d{10,11}\z/, message: 'is invalid' }

  def save
    purchase_record = PurchaseRecord.create(user_id:, item_id:)
    ShippingAddress.create(
      post_code:,
      prefecture_id:,
      municipality:,
      street_address:,
      building_name:,
      telephone_number:,
      purchase_record_id: purchase_record.id
    )
  end
end
