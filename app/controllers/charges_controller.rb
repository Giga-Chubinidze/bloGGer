class ChargesController < ApplicationController
  def new
  end
  
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
  flash[:notice] = "Great! You have Bough a VIP Rank"
  redirect_to root_path
  end
end