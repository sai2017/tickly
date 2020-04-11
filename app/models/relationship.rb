class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :follower_id, presence: true
  validates :following_id, presence: true

  def self.find_user_send_mail(following_id, current_user)
    active_relationship = Relationship.find_by(following_id: current_user.id, follower_id: following_id)
    passive_relationship = Relationship.find_by(following_id: following_id, follower_id: current_user.id)
    receive_user = User.find(following_id)
    # 自分からいいねしてた相手からいいねを返されたら、自分にメールが飛ぶ（相手には飛ばない）
    if active_relationship.present? && passive_relationship.present?
      if active_relationship.created_at > passive_relationship.created_at
        if current_user.mail_notificatoin_setting.matching_flag == true
          MatchingMailer.matching_to_user(current_user, receive_user).deliver
        end
      else
        if receive_user.mail_notificatoin_setting.matching_flag == true
          MatchingMailer.matching_to_user(receive_user, current_user).deliver
        end
      end
    end
    # 相手がいいねしてきたら、自分にメールが飛ぶ（相互フォローのときは飛ばない）
    if active_relationship.blank? && passive_relationship.present?
      if receive_user.mail_notificatoin_setting.like_flag == true
        FollowingMailer.following_to_user(receive_user, current_user).deliver
      end
    elsif passive_relationship.blank? && active_relationship.present?
      if current_user.mail_notificatoin_setting.like_flag == true
        FollowingMailer.following_to_user(current_user, receive_user).deliver
      end
    end
  end
end
