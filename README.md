# テーブル設計

## users Table

|Column|Type|Options|
|:----|:----|:----|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|encrypted_password|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|

### Association
- has_many :items
- has_many :purchase_records

## items Table
|Column|Type|Options|
|:----|:----|:----|
|user|references|null: false, foreign_key: true|
|product_name|string|null: false|
|product_description|text|null: false|
|category_id|integer|null: false|
|product_condition_id|integer|null: false|
|shipping_cost_id|integer|null: false|
|prefecture_id|integer|null: false|
|delivery_time_id|integer|null: false|
|price|integer|null: false|


### Association
- belongs_to :user
- has_one :purchase_record

## purchase_records Table
|Column|Type|Options|
|:----|:----|:----|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|


### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address


## purchase_records Table
|Column|Type|Options|
|:----|:----|:----|
|purchase_record|references|null: false, foreign_key: true|
|post_code|string|null: false|
|prefecture_id|integer|null: false|
|municipality|string|null: false|
|street_address|string|null: false|
|building_name|string||
|telephone_number|string|null: false|

### Association
- belongs_to :purchase_record
