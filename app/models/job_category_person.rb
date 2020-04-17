class JobCategoryPerson < ApplicationRecord
  belongs_to :person
  belongs_to :job_category
end
