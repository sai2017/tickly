class UsersController < ApplicationController
  def index
    if params[:profile_search_min_age].present?
      # 指定された年齢となる生年月日をyyyymmdd形式の文字列へと変換
      younger_birth_ymd = Profile.calc_younger_birthday(params[:profile_search_min_age]).to_s
      @search_min_age = params[:profile_search_min_age]
    else
      # 下限の年齢が未入力の場合は、上限以下のすべてのユーザーを取得するため0を渡しておく
      younger_birth_ymd = Profile.calc_younger_birthday("0").to_s
    end

    if params[:profile_search_max_age].present?
      older_birth_ymd = Profile.calc_older_birthday(params[:profile_search_max_age]).to_s
      @search_max_age = params[:profile_search_max_age]
    else
      # 上限の年齢が未入力の場合は、下限以上のすべてのユーザーを取得するため99を渡しておく
      older_birth_ymd = Profile.calc_older_birthday("99").to_s
    end

    # yyyymmdd形式の生年月日を日付形式に変換
    younger_birthday = Time.parse(younger_birth_ymd)
    older_birthday = Time.parse(older_birth_ymd)

    if params[:profile_search_min_age].blank? && params[:profile_search_max_age].blank?
      @q = Person.order(created_at: :desc).ransack(params[:q])
    elsif params[:profile_search_min_age].present? || params[:profile_search_max_age].present?
      @q = Person.order(created_at: :desc)
                 .includes(:profile)
                 .where(profiles: { birthday: older_birthday..younger_birthday })
                 .ransack(params[:q])
    end

    search_people = @q.result(distinct: true)
    # フォローorフォロワーの関係を持っていないユーザーを配列にして返す
    unrelationship_users = search_people.map do |person|
      user = User.find(person.user_id)
      unless user == current_user
        unless current_user.following?(user) || current_user.follower?(user)
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
    @profile = @user.person.profile
    @relationship = Relationship.new
    # ユーザー詳細画面に遷移したとき、自分がフォローしたレコードのnew_matching_flagをfalseに変える
    active_relationship = Relationship.find_by(following_id: @user.id, follower_id: current_user.id)
    passive_relationship = Relationship.find_by(following_id: current_user.id, follower_id: @user.id)
    # マッチングした状態でactive_relationshipのnew_matching_flagがtrueだったらfalseに変える
    if active_relationship.present? && passive_relationship.present? && active_relationship.new_matching_flag == true
      active_relationship.update(new_matching_flag: false)
    end
  end
end
