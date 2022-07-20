class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query 
  before_action :find_queried_posts

  include Pundit


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  private 

      def set_query 
        @query = policy_scope(Post).ransack(params[:q])
      end

      def find_queried_posts
        @postsed = @query.result.all.order("created_at DESC").paginate(page: params[:page], per_page: 2)
      end

      def user_not_authorized 
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to[request.referrer || root_path]
      end

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
      end

      def default_url_options
          {locale: I18n.locale}
      end

      def set_locale 
          I18n.locale = extract_locale || I18n.default_locale
      end

      def extract_locale
          parsed_locale = params[:locale]
          I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale.to_sym : nil
      end
end