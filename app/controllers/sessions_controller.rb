class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :login]
  def new
      # render login page
  end
  def login
    @user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
    puts "Helloooo"
    puts @user, "---------------------------------------------------------"
    if @user == nil || @user == false
      flash[:notice] = ["Invalid Combination"]
      redirect_to '/sessions/new'
    else
      session[:id] = @user.id
      session[:name] = @user.name
      redirect_to "/users/#{session[:id]}"
      
    end
  end
  def destroy
      session[:id] = nil
      session[:name] = nil
      redirect_to '/sessions/new'
  end
  
end