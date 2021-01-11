class Post < ApplicationRecord
  with_options presence: true do
    validates :image
    validates :subject
    validates :title
    validates :text
  end

  validates :title, length: { maximum: 16 }
  validates :text, length: { maximum: 60 }

  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.search(search)
    if search != ''
      Post.where('text LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
end
