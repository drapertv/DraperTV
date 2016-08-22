# encoding: utf-8

class VthumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :fog
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "elon-vid.png"
  end

  version :seriesthumb do 
    process :resize_to_fill => [512, 288]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end


end
