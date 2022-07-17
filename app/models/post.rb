class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  validates :title, length: { minimum: 5 }
  validates :body, presence: true

  CATEGORY = %w{VIP NORMAL}

end
