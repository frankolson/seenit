class Comment < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  after_create :increment_count
  after_destroy :decrement_count

  private

    def increment_count
      parent = commentable

      # Keep looping until we get to the parent which isn't a Comment model
      while parent.is_a? Comment
        parent = parent.commentable
      end

      parent.increment! :comments_count
    end

    def decrement_count
      parent = commentable

      # Keep looping until we get to the parent which isn't a Comment model
      while parent.is_a? Comment
        parent = parent.commentable
      end

      parent.decrement! :comments_count
    end
end
