class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :img_name, ImgNameUploader

  has_many :active_relationships,class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following, through: :active_relationships
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :messages
  has_many :message_room_users

  # 現在のユーザーがいいねしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def matchers
    following & followers
  end

end
