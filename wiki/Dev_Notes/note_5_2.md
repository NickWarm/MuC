尚未實作

# 預設@image的圖片

然後在user model validate

`default_url: ->(attachment) { ActionController::Base.helpers.asset_path('tmp/kitchen.png') }`


# 只顯示一次flash message

`flash.now[:notice]`
- [rails API - now()](http://api.rubyonrails.org/classes/ActionDispatch/Flash/FlashHash.html#method-i-now)
- [Flash訊息 - Ruby on Rails 實戰聖經 | Action Controller - 控制 HTTP 流程](https://ihower.tw/rails/actioncontroller.html#sec9)
