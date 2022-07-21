class ChargesController < ApplicationController

  def create
    @amount = 500
    
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )
    
    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => "Rails Stripe customer",
      :currency => "usd"
    )
    
    current_user.add_role :vip

    flash[:notice] = "Great! You have Bough a VIP Rank"
    redirect_to root_path
  end
end