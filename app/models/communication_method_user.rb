class CommunicationMethodUser < ApplicationRecord
  belongs_to :user
  belongs_to :communication_method
end
