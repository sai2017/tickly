class PurposeOfUseUser < ApplicationRecord
  belongs_to :user
  belongs_to :purpose_of_use
end
