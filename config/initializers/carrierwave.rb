require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory = 'yumetabi-storage'
  config.asset_host = 'http://yumetabi-storage.s3.amazonaws.com'
  config.fog_public = false
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
    aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    region: 'us-east-1',
    # path_style: true
  }
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  config.remove_previously_stored_files_after_update = false
end
# 日本語の文字化けを防ぐ
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/