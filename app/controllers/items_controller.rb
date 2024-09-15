class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    redirect_to root_path if current_user.id != @item.user_id || @item.purchase_record.present?
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.id == @item.user_id
      if @item.destroy
        redirect_to root_path
      else
        redirect_to item_path(@item), alert: 'failed to delete'
      end
    else
      redirect_to item_path(@item), alert: 'You are not authorized to delete this item'
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :product_condition_id, :shipping_cost_id,
                                 :prefecture_id, :delivery_time_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def go_to_root_path
    redirect_to root_path
  end
end
