class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :confirmable

  mount_uploader :img_name, ImgNameUploader

  has_many :active_relationships,class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following, through: :active_relationships
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :messages
  has_many :message_room_users

  has_one :like_point, dependent: :destroy

  has_one :mail_notification_setting, dependent: :destroy

  has_one :person, dependent: :destroy

  validates :name, presence: true

  validates :email, presence: true

  validates :password, presence: true

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        name:  auth.info.name,
        password: Devise.friendly_token[0, 20],
        remote_img_name_url:  auth.info.image.gsub("picture","picture?type=large")
      )
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

  def age
    birthday = self.birthday.strftime("%Y%m%d").to_i
    today = Date.today.strftime("%Y%m%d").to_i
    return (today - birthday) / 10000
  end

  # *********以下、生年月日から年齢の範囲検索をするためのメソッドたち*********

  # 渡された年齢に本日なったばかりの生年月日をyyyymmdd形式で出力
  def self.calc_younger_birthday(age)
    Date.today.strftime("%Y%m%d").to_i - age.to_i * 10000
  end
  # 渡された年齢であるギリギリの生年月日をyyyymmdd形式で出力
  def self.calc_older_birthday(age)
    Date.today.strftime("%Y%m%d").to_i - age.to_i * 10000 - 9999
  end

  # *************************** 以上 ***************************
end
