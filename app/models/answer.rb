class Answer < ApplicationRecord
  validates :text, presence: true

  belongs_to :user
  belongs_to :question
end
