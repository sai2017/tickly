class JobCategoryUser < ApplicationRecord
  belongs_to :user
  belongs_to :job_category
end
