class MypageController < ApplicationController
  def my_profile
    @current_person = Person.find_by(user_id: current_user.id)
    @current_person_profile = Profile.find_by(person_id: @current_person.id)
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
    redirect_back(fallback_location: root_path)
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
        :want_to_do, 
        :current_work,
        :communication_method, 
        :purpose_of_use, 
        :prefecture_id, 
        :remove_img_name
      ]
    )
  end
end
