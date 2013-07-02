class UsersController < ApplicationController

  before_filter :set_cur_user, :only => :show
  
	def new
		@user = User.new
		@users = User.all
	end
  
  def welcome
    @user = User.new
    @users = User.all
    
    @posts = Post.all
    
  end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			redirect_to posts_path
		else
			render :new
		end
	end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    
  end

end
