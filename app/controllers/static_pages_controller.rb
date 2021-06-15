class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.including_replies.with_attached_image.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
    
  end
  
  def contact
    
  end
end
