class PostsController < ApplicationController
	before_filter :ensure_signed_in, except: [:show]
  before_filter :ensure_not_guest, only: [:new, :create]
  before_filter :set_cur_user
  
	def index
		@posts = current_user.posts.order("created_at DESC")
	end
  
  def show
    
    if params[:id].to_i != 0
      @post = Post.find( params[:id] )
      @filter = nil
    else
      @posts = Post.where( filter: params[:id] ).order("created_at DESC")
      @filter = params[:id]
    end
    
    template = (@filter.nil?) ? 'posts/show' : 'posts/filtered'
    
    respond_to do |format|
      format.html { render :html, template: template }
      format.xml
    end
    
    
  end

	def new
		@post = current_user.posts.build
	end

	def create
    
		@post = Post.new(:title => params[:post][:title], :user_id => current_user.id, :body => params[:post][:body], :filter => params[:post][:filter] )
    
    if !params[:post][:video].nil?
    
      directory = 'app/assets/videos/'
      
      path = File.join(directory, params[:post][:video].original_filename) 
      
      tmp_file = File.read(params[:post][:video].tempfile)
      
      File.open(path, "w+") { |f| f.write tmp_file }
      
      @video = Video.create( :name => params[:post][:video].original_filename, :url => "/assets/#{params[:post][:video].original_filename}" )
      
      @post[:video_link] = @video.url
      
    end
    #current_user.posts.build(params[:post])
		if @post.save
			redirect_to posts_path, notice: "Post created successfully"
		else
			render :new
		end
	end

	def destroy
		@post = current_user.posts.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

end
