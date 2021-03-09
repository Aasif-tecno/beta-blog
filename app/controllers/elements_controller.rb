class ElementsController < ApplicationController
  before_action :set_blog
  before_action :set_element, only: %i[edit update destroy ]

  # GET /elements/1/edit
  def edit
  end

  # POST /elements or /elements.json
  def create
    @element = @blog.elements.build(element_params)

    respond_to do |format|
      if @element.save
        format.html { redirect_to edit_blog_path(@blog)}
        format.json { render :show, status: :created, location: @element }
      else
        format.html { redirect_to edit_blog_path(@blog), notice: @element.errors.full_messages.join(". ") << "."}
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /elements/1 or /elements/1.json
  def update
    respond_to do |format|
      @element.update(element_params)
        format.html { redirect_to edit_blog_path(@element.blog) }
    end
  end

  # DELETE /elements/1 or /elements/1.json
  def destroy
    @element.destroy
    respond_to do |format|
      format.html { redirect_to edit_blog_path(@element.blog) }
      format.json { head :no_content }
    end
  end

  private

    def set_blog
      @blog = current_user.blogs.find(params[:blog_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_element
      @element = @blog.elements.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def element_params
      params.require(:element).permit(:element_type, :content, :image)
    end
end
