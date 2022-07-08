class PostDecorator < ApplicationDecorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end
  
  def published_at
    self.l(created_at, format: "%A, %B %e")
  end

  def edit_if_author
    if h.current_user == model.user
      h.link_to(h.t(:edit), "/#{I18n.locale}/posts/#{self.id}/edit", class:"btn btn-primary", style:"position:relative; bottom:38px;")
    end
  end

  def delete_if_author
    if h.current_user == model.user
      h.button_to(h.t(:delete), @post, method: :delete, data: {confirm: "Are you sure?"}, class:"btn btn-primary", style:"position:relative; left: #{lang_detector}px;")
    end
  end

  private 
    def lang_detector
      case I18n.locale
      when :en
        return 60
      when :ka
        return 140
      end
    end

end
 

