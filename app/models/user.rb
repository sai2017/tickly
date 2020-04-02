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

  belongs_to :prefecture, optional: true

  has_many :communication_method_users
  has_many :communication_methods, through: :communication_method_users

  has_many :purpose_of_use_users
  has_many :purpose_of_uses, through: :purpose_of_use_users

  has_many :job_category_users
  has_many :job_categories, through: :job_category_users

  # 現在のユーザーがいいねしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def matchers
    following & followers
  end

  scope :matching, -> user_id {
    joins("INNER JOIN relationships ON relationships.follower_id = users.id
           INNER JOIN relationships AS r ON relationships.following_id = r.follower_id 
           AND r.following_id = relationships.follower_id
           INNER JOIN relationships AS n 
           ON n.created_at = 
            (CASE WHEN 
               relationships.created_at > r.created_at THEN relationships.created_at 
             ELSE r.created_at END)"
    ).where('relationships.following_id = ?', user_id).order('n.created_at DESC') 
  }

end
