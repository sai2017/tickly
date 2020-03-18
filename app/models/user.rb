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

  enum communication_method: { 
    対面で話したい: 0,
    オンラインで話したい: 1,
    まずはメッセージのみで話したい: 2,
    通話したい: 3,
  }

  enum purpose_of_use: { 
    採用したい: 0,
    ビジネスパートナーを見つけたい: 1,
    情報交換したい: 2,
    起業仲間を見つけたい: 3,
    案件を探したい: 4,
    視野を広げたい: 5,
    知識・経験を提供したい: 6,
    VC・投資家を探したい: 7,
    投資先を探したい: 8,
    友達を作りたい: 9,
    就活したい: 10
  }

  # 現在のユーザーがいいねしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def matchers
    following & followers
  end

end
