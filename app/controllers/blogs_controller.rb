class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ edit update destroy ]
  before_action :authenticate_user!, except: [:show]
  # GET /blogs or /blogs.json
  def index
    @blogs = current_user.blogs
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @blog = Blog.published.friendly.find(params[:id])
    impressionist(@blog)
  end

  # GET /blogs/new
  def new
    @blog = current_user.blogs.build
  end

  # GET /blogs/1/edit
  def edit
    @element = @blog.elements.build
  end

  # POST /blogs or /blogs.json
  def create
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to edit_blog_path(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to edit_blog_path(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = current_user.blogs.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :description, :header_image)
    end
end
