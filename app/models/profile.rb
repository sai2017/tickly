class Profile < ApplicationRecord
  belongs_to :person
  mount_uploader :img_name, ImgNameUploader

  belongs_to :prefecture, optional: true

  validates :company_name, length: { maximum: 50 }
  validates :self_introduction, length: { maximum: 2000 }
  validates :occupation, length: { maximum: 50 }
  validates :catch_copy, length: { maximum: 50 }
  validates :original_experience, length: { maximum: 2000 }
  validates :want_to_do, length: { maximum: 2000 }
  validates :current_work, length: { maximum: 2000 }

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
