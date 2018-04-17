class UsersController < ApplicationController
  def new
  end

  def show
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
    @user = User.find(session[:id])
  end
  def destroy
    @user = User.find(session[:id])
    @user.delete
    session[:id] = nil
    session[:name] = nil
    redirect_to '/users/new'
  end
end
