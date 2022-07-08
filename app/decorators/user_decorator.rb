class UserDecorator < ApplicationDecorator
  delegate_all

  def show_if_signed_in
    link_to(h.t(:current_user) + ": " + h.current_user[:email], root_path, style:"color:white;")
  end

end
