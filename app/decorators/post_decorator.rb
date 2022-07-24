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
      h.render "posts/edit"
      # h.link_to(h.t(:edit), "/#{I18n.locale}/posts/#{self.id}/edit", class:"btn btn-primary", style:"position:relative; bottom:38px;")
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
      h.image_tag("https://cdn3.iconfinder.com/data/icons/flaticons-1/24/flaticon_user-512.png", style:"width:150px; height:200px; height:auto; border-radius: 50%;")
    end
  end

  def user_logged?
    h.current_user ? true : false
  end
  
  def like_button
    if user_logged?
      @pre_like = post.likes.find { |like| like.user_id == h.current_user.id}
      @pre_dislike = post.dislikes.find { |dislike| dislike.user_id == h.current_user.id}
      disabled_value_like = @pre_dislike ? true : false
      like_icon_styling = "width:4%; height:4%; position:relative; top:91px; left: 1170px;"
      
      if @pre_like
        butt_on(disabled_value_like, h.image_tag("thumbsupturned.png", style:like_icon_styling), h.delete_like_path(post, @pre_like), data: {turbo_method: :delete})
      else
        butt_on(disabled_value_like, h.image_tag("thumbsup.png", style:like_icon_styling), h.create_like_path(post), data: {turbo_method: :post})
      end
    end
  end

  def dislike_button
    if user_logged?
      disabled_value_dislike = @pre_like ? true : false 
      dislike_icon_styling = "width:4%; height:4%; position:relative; left:50px; top:40px; left: 1230px;"
      if @pre_dislike
        butt_on(disabled_value_dislike, h.image_tag("thumbsdownturned.png", style:dislike_icon_styling), h.delete_dislike_path(post, @pre_dislike), data: {turbo_method: :delete})
      else
        butt_on(disabled_value_dislike, h.image_tag("thumbsdown.png", style:dislike_icon_styling), h.create_dislike_path(post), data: {turbo_method: :post})
      end
    end
  end

  def like_count
    "#{post.likes.count} #{(post.likes.count) == 1 ? 'Like' : 'Likes'}"
  end

  def dislike_count 
    "#{post.dislikes.count} #{(post.dislikes.count) == 1 ? 'Dislike' : 'Dislikes'}"
  end

  private
    def butt_on(cond, img, path, data)
      h.link_to_unless cond, img, path, data
    end 
    
    def lang_detector
      case I18n.locale
      when :en
        return 60
      when :ka
        return 140
      end
    end

end
 

