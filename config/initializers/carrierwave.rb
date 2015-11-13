# -*- coding: utf-8 -*-
# if Rails.env.development? || Rails.env.test?
#   CarrierWave.configure do |config|
#     config.storage = :file
#     config.enable_processing = false if Rails.env.test?
#   end
# else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key:  Rails.application.secrets.aws_secret_access_key,
      region:                 Rails.application.secrets.aws_region
    }
    config.fog_directory = Rails.application.secrets.aws_fog_directory
    config.storage = :fog
    config.fog_public = false
    config.fog_authenticated_url_expiration = 60 * 60 * 24
  end
# end
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/