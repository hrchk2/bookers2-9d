class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :latest, -> {order(created_at: :desc)}
  scope :star_count, -> {order(rate: :desc)}
  
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end
  
end
