class CommunicationMethod < ApplicationRecord
  has_many :communication_method_users
  has_many :users, through: :communication_method_users
end
