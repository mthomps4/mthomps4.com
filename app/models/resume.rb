# frozen_string_literal: true

class Resume < ApplicationRecord
  mount_uploader :file, ResumeUploader
end
