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
      h.button_to(h.t(:delete), model, method: :delete, data: {confirm: "Are you sure?"}, class:"btn btn-primary", style:"position:relative; left: #{lang_detector}px;")
    end
  end

  def show_avatar
    if post.user.avatar?
      h.image_tag(model.user.avatar_url(:thumb), style:"width:150px; height:200px; height:auto;")
    else
      h.image_tag("https://cdn3.iconfinder.com/data/icons/flaticons-1/24/flaticon_user-512.png", style:"width:150px; height:200px; height:auto;   border-radius: 50%;")
    end
  end

  def like_button
    pre_like = post.likes.find { |like| like.user_id == h.current_user.id}
    pre_dislike = post.dislikes.find { |dislike| dislike.user_id == h.current_user.id}

    disabled_value_like = pre_dislike ? true : false

    if pre_like
      h.link_to h.image_tag("thumbsupturned.png", style:"width:4%; height:4%;"), h.delete_like_path(post, pre_like), data: {turbo_method: :delete}, :disabled => disabled_value_like, style:"position:relative; top:91px; left: 1170px;"
    else
      h.link_to h.image_tag("thumbsup.png", style:"width:4%; height:4%;"), h.create_like_path(post), data: {turbo_method: :post}, :disabled => disabled_value_like, style:"position:relative; top:91px; left: 1170px;"
    end
  end

  def dislike_button
    pre_like = post.likes.find { |like| like.user_id == h.current_user.id}
    pre_dislike = post.dislikes.find { |dislike| dislike.user_id == h.current_user.id}
    
    disabled_value_dislike = pre_like ? true : false 

    if pre_dislike
      h.link_to h.image_tag("thumbsdownturned.png", style:"width:4%; height:4%;"), delete_dislike_pat(@post, pre_dislike), method: :delete, :disabled => disabled_value_dislike, style:"color: white; background-color:red; position:relative; left:50px; top:40px; left: 1230px;", class:"react"
    else
      h.link_to h.image_tag("thumbsdown.png", style:"width:4%; height:4%;"), create_dislike_path(@post), method: :post, :disabled => disabled_value_dislike, style:"color: white; background-color:green; position:relative; left:50px; top:40px; left: 1230px;", class:"react"

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
 

