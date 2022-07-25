class User < ApplicationRecord
  rolify
  has_many :posts, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :places, dependent: :destroy
  
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  validate :must_have_a_role, on: :update 

  private 
    def assign_default_role
      self.add_role(:member) if self.roles.blank?
    end

    def must_have_a_role
      unless roles.any? 
        errors.add(:roles, "Must have at least 1 role")
      end
    end

end
