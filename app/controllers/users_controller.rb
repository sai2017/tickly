class UsersController < ApplicationController
  def index
    if params[:search_min_age].present?
      # 指定された年齢となる生年月日をyyyymmdd形式の文字列へと変換
      younger_birth_ymd = User.calc_younger_birthday(params[:search_min_age]).to_s
      @search_min_age = params[:search_min_age]
    else
      # 下限の年齢が未入力の場合は、上限以下のすべてのユーザーを取得するため0を渡しておく
      younger_birth_ymd = User.calc_younger_birthday("0").to_s
    end

    if params[:search_max_age].present?
      older_birth_ymd = User.calc_older_birthday(params[:search_max_age]).to_s
      @search_max_age = params[:search_max_age]
    else
      # 上限の年齢が未入力の場合は、下限以上のすべてのユーザーを取得するため99を渡しておく
      older_birth_ymd = User.calc_older_birthday("99").to_s
    end

    # yyyymmdd形式の生年月日を日付形式に変換
    younger_birthday = Time.parse(younger_birth_ymd)
    older_birthday = Time.parse(older_birth_ymd)

    if params[:search_min_age].blank? && params[:search_max_age].blank?
      @q = User.ransack(params[:q])
    elsif params[:search_min_age].present? || params[:search_max_age].present?
      @q = User.where(birthday: older_birthday..younger_birthday).ransack(params[:q])
    end

    job_category_users = @q.result(distinct: true).includes(:job_categories)
    # フォローorフォロワーの関係を持っていないユーザーを配列にして返す
    unrelationship_users = job_category_users.map do |user|
      if user != current_user
        if !current_user.following?(user) || !current_user.follower?(user)
          user
        end
      end
    end
    delete_nil_users = unrelationship_users.compact
    # 配列に対してページングするためpaginate_arrayを使用
    @users = Kaminari.paginate_array(delete_nil_users).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end
end
