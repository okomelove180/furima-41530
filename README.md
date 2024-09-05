# テーブル設計

## users Table

|Column|Type|Options|
|:----|:----|:----|
|nickname|string|null: false, unique: true|
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
|product_image|string|null: false|
|product_name|string|null: false|
|product_description|text|null: false|
|category|string|null: false|
|product_condition|string|null: false|
|shipping_cost|integer|null: false|
|region_of_origin|string|null: false|
|delivery_time|string|null: false|
|price|integer|null: false|


### Association
- belongs_to :users
- has_many :purchase_records

## purchase_records Table
|Column|Type|Options|
|:----|:----|:----|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|


### Association
- belongs_to :users
- belongs_to :items
- has_one :shipping-addresses


## purchase_records Table
|Column|Type|Options|
|:----|:----|:----|
|post_code|string|null: false|
|prefecture|string|null: false|
|municipality|string|null: false|
|street_address|string|null: false|
|building_name|string|null: false|
|telephone_number|string|null: false|

### Association
- belongs_to :purchase_records
