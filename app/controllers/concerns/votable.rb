module Votable
  extend ActiveSupport::Concern

  def upvote
    votable_record.upvote_by current_user
    flash[:success] = 'Link was successfully upvoted.'
    redirect_back fallback_location: root_url
  end

  def downvote
    votable_record.downvote_from current_user
    flash[:success] = 'Link was successfully downvoted.'
    redirect_back fallback_location: root_url
  end

  private

    def votable_record
      @votable_record ||= controller_name.classify.constantize.find(params[:id])
    end
end
