class JobCategory < ApplicationRecord
  has_many :job_category_users
  has_many :users, through: :job_category_users
end
