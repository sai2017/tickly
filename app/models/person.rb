class Person < ApplicationRecord
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :communication_method_people, dependent: :destroy
  has_many :communication_methods, through: :communication_method_people

  has_many :purpose_of_use_people, dependent: :destroy
  has_many :purpose_of_uses, through: :purpose_of_use_people

  has_many :job_category_people, dependent: :destroy
  has_many :job_categories, through: :job_category_people

  belongs_to :user
end
