class PhoneNumbersController < ApplicationController

  def new
    @phone_number = PhoneNumber.new()
  end

  def create
    if valid_phone?
      current_user.phone_numbers.create(:number => params[:phone_number][:number], :country => params[:phone][:country])
      flash[:notice] = "Number created"
      redirect_to profile_path(current_user)
    else
      flash[:alert] = "Invalid parameters"
      redirect_to add_phone_number_path
    end
  end

  def destroy 

  end

  private 
    def phone_number_params
      params.require(:phone_number).permit(:number, :country)
    end

    def valid_phone?
      TelephoneNumber.parse(params[:phone_number][:number], params[:phone][:country]).valid?
    end
end
