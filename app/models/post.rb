class Post < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :subject
    validates :title
    validates :text
  end
  
  belongs_to :user
  has_one_attached :image
end
