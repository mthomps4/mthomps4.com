class ResumeUploader < CarrierWave::Uploader::Base
  # Set the storage to :file or :fog for AWS S3
  storage :aws

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_whitelist
    %w[pdf]
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    'uploads/resume/'
  end

  # Override the filename of the uploaded files
  def filename
    "resume-#{timestamp}.pdf" if original_filename
  end

  private

  # Generate a timestamp for use in the file name
  def timestamp
    @timestamp ||= Time.now.to_i
  end
end
