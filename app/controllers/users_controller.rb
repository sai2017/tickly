class UsersController < ApplicationController
  def index
    # 指定された年齢となる生年月日をyyyymmdd形式の文字列へと変換
    younger_birth_ymd = User.calc_younger_birthday(params[:search_min_age]).to_s
    older_birth_ymd = User.calc_older_birthday(params[:search_max_age]).to_s
  # yyyymmdd形式の生年月日を日付形式に変換
    younger_birthday = Time.parse(younger_birth_ymd)
    older_birthday = Time.parse(older_birth_ymd)
    @q = User.where(birthday: older_birthday..younger_birthday).ransack(params[:q])
    @job_categories = JobCategory.all
    @users = @q.result(distinct: true).includes(:job_categories).page(params[:page]).per(2)
  end

  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end
end
