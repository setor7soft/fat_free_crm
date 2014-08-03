Paperclip.interpolates :default_image_url do |attachment, style|
  ActionController::Base.helpers.asset_path("missing_#{style}.png")
end
