class Post < ApplicationRecord
  belongs_to :user

  validates :title, length: { minimum: 5 }
  validates :body, presence: true
  has_many :comments, dependent: :destroy
end
