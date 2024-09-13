class OrdersController < ApplicationController
  def index
    @purchase_form = PurchaseRecordShippingAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @purchase_form = PurchaseRecordShippingAddress.new(purchase_record_shipping_address_params)
    if @purchase_form.valid?
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
end
