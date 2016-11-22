class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @post =  Post.new    
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[ :id ])
  end

  # GET /posts/new
  def new
    @post = Post.new(:parent_id => params[:parent_id])
  end

  # GET /posts/1/edit
  def edit
     @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
        @post = Post.new(post_params)  
        @post.email = current_user.email
    if @post.save      
      redirect_to action: 'index'
    else
      render :action => "new"
    end
  

 end


  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy   
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :parent_id)
    end
end