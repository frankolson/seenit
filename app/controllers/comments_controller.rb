class CommentsController < ApplicationController
  before_action :authorized_user

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.link_id = params[:link_id]
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Comment was successfully created.'
      redirect_to @comment.link
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    flash[:success] = 'Comment was successfully destroyed.'
    redirect_back fallback_location: root_url
  end

  private

    def set_comment
      @comment = current_user.comments.find_by(id: params[:id])
    end

    def authorized_user
      set_comment

      if @comment.nil?
        flash[:error] = "Sorry, you can't edit someone else's comments."
        redirect_back fallback_location: root_path
      end
    end

    def comment_params
      params.require(:comment).permit(:user_id, :link_id, :content)
    end
end
