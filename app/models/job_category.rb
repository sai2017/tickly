class JobCategory < ApplicationRecord
  has_many :job_category_people
  has_many :people, through: :job_category_people
end
