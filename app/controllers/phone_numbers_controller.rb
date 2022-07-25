class PhoneNumbersController < ApplicationController


  def index 
    @phone_numbers = PhoneNumber.all()
  end

  def show 
  end

  def new
    @phone_number = PhoneNumber.new()
  end

  def destroy
    flash[:notice] = "Zd"
    phone = Phone.find_by(id: params[:id])
    phone.destroy
    redirect_to phone_numbers_path(current_user)
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
