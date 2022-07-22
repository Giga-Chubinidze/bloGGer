class Post < ApplicationRecord
  rolify

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  validates :title, length: { minimum: 5 }
  validates :body, presence: true


  def self.disapprove_after_10_days_of_inactivity
    Post.all.each do |post|
      if post.created_at + 10.days < Time.now && post.likes.count.zero? && post.dislikes.count.zero?
        post.update(approval_status: false)
        puts "changed the post with the id of #{post.id} status to inactive"
      end
    end
  end
end
