class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.id == Item.find(params[:item_id]).user_id || Item.find(params[:item_id]).purchase_record.present?
      redirect_to root_path
    else
      @purchase_form = PurchaseRecordShippingAddress.new
      @item = Item.find(params[:item_id])
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_form = PurchaseRecordShippingAddress.new(purchase_record_shipping_address_params)
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_shipping_address_params
    params.require(:purchase_record_shipping_address).permit(:post_code, :prefecture_id, :municipality, :street_address,
                                                             :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = 'sk_test_177e395bb5c3b560ea05c5f5' # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_record_shipping_address_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
