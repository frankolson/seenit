class CommentsController < ApplicationController
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.link_id = params[:link_id]
    @comment.user = current_user

    if @comment.save
      redirect_to @comment.link, notice: 'Comment was successfully created.'
    else
      redirect_back fallback_location: root_path,
        alert: @comment.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      redirect_to @comment.link, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = current_user.comments.find_by(id: params[:id])
    end

    def authorized_user
      set_comment

      if @comment.nil?
      redirect_back fallback_location: root_path,
        notice: "Sorry, you can't edit someone else's comments"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :link_id, :content)
    end
end
