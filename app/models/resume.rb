class Resume < ApplicationRecord
  mount_uploader :file, ResumeUploader
end
