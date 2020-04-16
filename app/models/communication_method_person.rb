class CommunicationMethodPerson < ApplicationRecord
  belongs_to :person
  belongs_to :communication_method
end
