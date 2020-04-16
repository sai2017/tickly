class Profile < ApplicationRecord
  belongs_to :person
  mount_uploader :img_name, ImgNameUploader
end
