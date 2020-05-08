class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :access, :rails_admin   # 管理者ページへのアクセスを許可
      can :manage, :all           # 全ての権限を付与
    end 
  end
end
