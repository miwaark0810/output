class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true, length: { maximum: 8 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'Include both letters and numbers'
  }
  validates :grade_id, numericality: { other_than: 1, message: 'Select' }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :questions

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :grade
end



