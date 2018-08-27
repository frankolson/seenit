class CommentsController < ApplicationController
  include Votable

  before_action :set_comment, except: [:create]
  before_action :set_commentable, only: [:create]
  before_action :authorized_user, only: [:destroy]

  # POST /comments
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Comment was successfully created.'
      redirect_back fallback_location: root_path
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  def insert_reply_form
  end

  def remove_reply_form
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

    def set_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Link.find_by_id(params[:link_id]) if params[:link_id]
    end

    def authorized_user
      if @comment.nil?
        flash[:error] = "Sorry, you can't edit someone else's comments."
        redirect_back fallback_location: root_path
      end
    end

    def comment_params
      params.require(:comment).permit(:user_id, :link_id, :content)
    end
end
