class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :follower_id, presence: true
  validates :following_id, presence: true

  # 自分からいいねしてた相手からいいねを返されたら、自分にメールが飛ぶ（相手には飛ばない）
  def self.find_user_send_mail(following_id, current_user)
    active_relationship = Relationship.find_by(following_id: current_user.id, follower_id: following_id)
    passive_relationship = Relationship.find_by(following_id: following_id, follower_id: current_user.id)
    receive_user = User.find(following_id)
    if active_relationship.present? && passive_relationship.present?
      if active_relationship.created_at > passive_relationship.created_at
        MatchingMailer.matching_to_user(current_user, receive_user).deliver
      else
        MatchingMailer.matching_to_user(receive_user, current_user).deliver
      end
    end  
  end
end
