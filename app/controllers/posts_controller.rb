class PostsController < ApplicationController

  def index
    @posts = Post.all
    
    # how to let other applications access the data?
    # alternative responses to requests other than HTML
    respond_to do |format| 
      format.html # implicitly renders posts/index.html.erb
    # format.json do
    # render:json => @posts # gives you data in json format if you went to posts.json
    end
  end

  def new
    @post = Post.new
  end

  def create
    if @current_user
      @post = Post.new
      @post["body"] = params["post"]["body"]
      @post["image"] = params["post"]["image"]
      @post.uploaded_image.attach(params["post"]["uploaded_image"])
      @post["user_id"] = @current_user["id"]
      @post.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/posts"
  end

  before_action :allow_cors # way to protect app so javascript code doesn't attack application (????)
  def allow_cors
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end

end
