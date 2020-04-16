class CommunicationMethod < ApplicationRecord
  has_many :communication_method_people
  has_many :people, through: :communication_method_people
end
