class Person < ApplicationRecord
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  belongs_to :user

  has_many :communication_method_people
  has_many :communication_methods, through: :communication_method_people
end
