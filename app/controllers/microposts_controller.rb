class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    regexp = /\A(@\w+)/
    if regexp.match(micropost_params[:content])
      unique_id = regexp.match(micropost_params[:content]).to_s
      unique_id.slice!('@')
      puts unique_id
      replied_user = User.find_by(unique_id: unique_id)
      puts replied_user
      if replied_user
        params[:micropost][:in_reply_to] = replied_user.id
      end
    end
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = current_user.including_replies.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    redirect_back(fallback_location: root_url)
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :image, :in_reply_to)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
