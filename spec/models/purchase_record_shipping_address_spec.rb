require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  describe '商品購入記録の保存' do
    before do
      @user = FactoryBot.build(:user)
      @item = FactoryBot.build(:item)
      @purchase_record_shipping_address = FactoryBot.build(:purchase_record_shipping_address, user_id: @user,
                                                                                              item_id: @item)
    end

    context '商品購入記録が保存できる場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_record_shipping_address).to be_valid
      end
      it '建物名が空でも保存できること' do
        @purchase_record_shipping_address.building_name = ''
        expect(@purchase_record_shipping_address).to be_valid
      end
    end

    context '商品購入記録が保存できない場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_record_shipping_address.post_code = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @purchase_record_shipping_address.post_code = '1234567'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が"---"だと保存できないこと' do
        @purchase_record_shipping_address.prefecture_id = 1
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_record_shipping_address.municipality = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @purchase_record_shipping_address.street_address = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @purchase_record_shipping_address.telephone_number = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号が9桁以下だと購入できないこと' do
        @purchase_record_shipping_address.telephone_number = '123456789'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it '電話番号が12桁以上だと購入できないこと' do
        @purchase_record_shipping_address.telephone_number = '123456789012'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it '電話番号が英数混合だと購入できないこと' do
        @purchase_record_shipping_address.telephone_number = '1234567890a'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it '電話番号が半角でないと購入できないこと' do
        @purchase_record_shipping_address.telephone_number = '１２３４５６７８９０'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include('Telephone number is invalid')
      end
      it 'tokenが空では購入できないこと' do
        @purchase_record_shipping_address.token = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では購入できないこと' do
        @purchase_record_shipping_address.user_id = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では購入できないこと' do
        @purchase_record_shipping_address.item_id = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
