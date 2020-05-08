class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :confirmable

  has_many :active_relationships,class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following, through: :active_relationships
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :messages, dependent: :destroy
  has_many :message_room_users, dependent: :destroy

  has_one :like_point, dependent: :destroy

  has_one :mail_notification_setting, dependent: :destroy

  has_one :person, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        password: Devise.friendly_token[0, 20],
      )
      person = user.build_person
      person.build_profile(
        name: auth.info.name, 
        remote_img_name_url: auth.info.image.gsub("picture","picture?type=large")
      )
    else
      if user.person.profile.name != auth.info.name
        user.person.profile.update(name: auth.info.name)
      end

      if user.person.profile.img_name != auth.info.image
        user.person.profile.update(remote_img_name_url: auth.info.image.gsub("picture","picture?type=large"))
      end
    end

    user
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 現在のユーザーがいいねされていたらtrueを返す
  def follower?(other_user)
    followers.include?(other_user)
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

  def update_without_current_password(params, *options)
    # params.delete(:current_password) で current_password のパラメータを削除。
    params.delete(:current_password)

    # パスワード変更のためのパスワード入力フィールドとその確認フィールドの両者とも空の場合のみ、パスワードなしで更新できるようにするためです。
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
