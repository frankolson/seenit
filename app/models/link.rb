class Link < ApplicationRecord
  acts_as_votable

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
