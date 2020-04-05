class UsersController < ApplicationController
  def index
    if params[:search_min_age].present?
      # 指定された年齢となる生年月日をyyyymmdd形式の文字列へと変換
      younger_birth_ymd = User.calc_younger_birthday(params[:search_min_age]).to_s
    else
      # 下限の年齢が未入力の場合は、上限以下のすべてのユーザーを取得するため0を渡しておく
      younger_birth_ymd = User.calc_younger_birthday("0").to_s
    end

    if params[:search_max_age].present?
      older_birth_ymd = User.calc_older_birthday(params[:search_max_age]).to_s
    else
      # 上限の年齢が未入力の場合は、下限以上のすべてのユーザーを取得するため99を渡しておく
      older_birth_ymd = User.calc_older_birthday("99").to_s
    end

    # yyyymmdd形式の生年月日を日付形式に変換
    younger_birthday = Time.parse(younger_birth_ymd)
    older_birthday = Time.parse(older_birth_ymd)

    if younger_birthday.present? || older_birthday.present?
      @q = User.where(birthday: older_birthday..younger_birthday).ransack(params[:q])
    else
      @q = User.ransack(params[:q])
    end

    @job_categories = JobCategory.all
    @users = @q.result(distinct: true).includes(:job_categories).page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end
end
