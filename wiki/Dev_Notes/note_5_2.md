預設圖片

然後在user model validate

`default_url: ->(attachment) { ActionController::Base.helpers.asset_path('tmp/kitchen.png') }`
