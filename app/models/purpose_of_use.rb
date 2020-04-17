class PurposeOfUse < ApplicationRecord
  has_many :purpose_of_use_people
  has_many :people, through: :purpose_of_use_people
end
