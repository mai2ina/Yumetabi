require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  if Rails.env.production?  
    config.fog_directory = ENV['FOG_DIRECTORY_NAME']  
    config.asset_host = ENV['ASSET_HOST']
    config.fog_credentials = {  
        provider: 'AWS',  
        aws_access_key_id: ENV['ACCESS_KEY_ID'],  
        aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],  
        region: ENV['REGION_CODE'],  
    }  
  else
    config.fog_directory = Rails.application.credentials.aws[:fog_directory_name]
    config.asset_host = Rails.application.credentials.aws[:asset_host]
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region: Rails.application.credentials.aws[:region_code]
    }
  end

  config.fog_public = false  
  # path_style: true
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}
  config.remove_previously_stored_files_after_update = false
end
# 日本語の文字化けを防ぐ
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/