class LikesController < ApplicationController
  before_action :require_login
  def create
    @like = Like.create(user_id: session[:id], secret_id: params[:secretid])
    redirect_to '/secrets'
  end

  def destroy
    @like = Like.find_by(user: current_user, secret: Secret.find(params[:secretid]))
    @like.destroy if @like
    redirect_to "/secrets"
  end
end
