class PurposeOfUsePerson < ApplicationRecord
  belongs_to :person
  belongs_to :purpose_of_use
end
