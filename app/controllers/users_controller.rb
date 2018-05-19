class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :secret_user, only: [:show, :edit, :destroy]
  def new
  end

  def show
    
    @user = User.find(params[:id])
    @secrets = @user.secrets
  end

  def create
    @user = User.new(email: params[:email], name: params[:name], password: params[:password])
    print @user.valid?
    if @user.valid? == true
      @user.save
      redirect_to '/sessions/new'
    else
      flash[:notice] = ["can't be blank"]
      redirect_to '/users/new'
    end
  end

  def secret
   @secret = Secret.create(content: params[:content], user_id: session[:id])
   redirect_to "/users/#{session[:id]}"
  end
  def delsecret
    if current_user.id != params[:id].to_i
      redirect_to "/users/#{current_user.id}"
    else
      @secret = Secret.find(params[:secretid])
      @secret.delete
      redirect_to "/users/#{session[:id]}"
    end
  end
  def update
    puts "session id is ", session[:id]
    @user = User.find(session[:id])
    if @user.update_attributes(name: params[:name], email: params[:email])
      session[:name] = @user.name
      redirect_to "/users/#{session[:id]}/edit"
    else
      flash[:notice] = ["Email is invalid"]
      redirect_to "/users/#{session[:id]}/edit"
    end



  end

  def edit
  
    @user = User.find(params[:id])
  end
  def destroy

    @user = User.find(session[:id])
    @user.delete
    session[:id] = nil
    session[:name] = nil
    redirect_to '/users/new'
  end

  private 

  def secret_user
    if current_user.id != params[:id].to_i
      redirect_to "/users/#{current_user.id}"
    end
  end
end
