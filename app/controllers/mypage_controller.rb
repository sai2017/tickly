class MypageController < ApplicationController
  def index
    @current_person = Person.find_by(user_id: current_user.id)
  end

  def edit
    @current_person = Person.find_by(user_id: current_user.id)
  end

  def update
    @current_person = Person.find_by(user_id: current_user.id)

    if @current_person.update(profile_params)
      flash[:success] = "プロフィールを更新しました"
    else
      flash[:error] = 'プロフィールの更新に失敗しました。' 
    end
    redirect_back(fallback_location: edit_mypage_path)
  end

  private

  def profile_params
    params.require(:person).permit(
      communication_method_ids: [],
      purpose_of_use_ids: [],
      job_category_ids: [],
      profile_attributes: [
        :id,
        :name, 
        :birthday, 
        :age, 
        :company_name, 
        :self_introduction, 
        :img_name, 
        :occupation, 
        :catch_copy, 
        :original_experience, 
        :purpose_of_working, 
        :weakness,
        :want_to_do, 
        :want_to_connect, 
        :communication_method, 
        :purpose_of_use, 
        :prefecture_id, 
        :remove_img_name
      ]
    )
  end
end
