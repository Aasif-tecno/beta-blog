class DiscussionsController < ApplicationController
  before_action :set_discussion, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /discussions or /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1 or /discussions/1.json
  def show
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
    @discussion.posts.new
  end

  # GET /discussions/1/edit
  def edit
  end

  # POST /discussions or /discussions.json
  def create
    @discussion = current_user.discussion.new(discussion_params)
    @discussion.posts.each{|post| post.user = current_user }
    
    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: "Discussion was successfully created." }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1 or /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: "Discussion was successfully updated." }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1 or /discussions/1.json
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: "Discussion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def discussion_params
      params.require(:discussion).permit(:user_id, :title, posts_attributes: [:body])
    end
end
