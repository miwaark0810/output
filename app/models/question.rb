class Question < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :subject
    validates :title
    validates :text
  end
end
