class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  with_options presence: true do
    validates :subject
    validates :title
    validates :text
  end

  validates :title, length: { maximum: 16 }
  validates :text, length: { maximum: 200 }
end
