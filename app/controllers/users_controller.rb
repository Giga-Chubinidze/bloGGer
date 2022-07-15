class UsersController < ApplicationController
    
    def edit
        @user = User.find_by(id: params[:id])
    end
    
    def index
        @users = User.order(created_at: :desc)
    end

    def update 
        @user = User.find_by(id: params[:id])
        if @user.update(user_params)
            redirect_to users_url, notice: "Updated"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private
        def user_params
            params.require(:user).permit({role_ids: []})
        end

    
end
  