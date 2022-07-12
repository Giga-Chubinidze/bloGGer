class PhoneNumbersController < ApplicationController

  def new 
    @phone_number = PhoneNumber.new 
  end

  def create
    @phone_number = PhoneNumber.new 
    @phone_number.create(phone_number_params)
  end

  def destroy 

  end

  private 
    def phone_number_params
      params.require(:phone_number).permit(:country, :number)
    end
end
