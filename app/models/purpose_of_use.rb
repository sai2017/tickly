class PurposeOfUse < ApplicationRecord
  has_many :purpose_of_use_users
  has_many :users, through: :purpose_of_use_users
end
