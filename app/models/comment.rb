class Comment < ApplicationRecord

  belongs_to :commentable, polymorphic: true

  validates :content, presence: true, length: { maximum: 50 }

  private
  
end
