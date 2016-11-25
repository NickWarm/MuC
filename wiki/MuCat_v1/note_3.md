# 實驗室成員註冊、登入、編輯個人資訊

情境：

>實驗室成員可以透過臉書帳號登入與註冊
>1. 在首頁有登入連結
>2. 註冊頁面是在「特殊網址」的頁面，註冊完後會跳轉到個人資訊的頁面，來編輯個人資料
>3. 註冊方式：由老師寄信給實驗室成員註冊網址，信中註明不能讓該網址外流

詳情請參考[implement_login.md](../../features/login_OmniAuth/implement_login.md)

# 實作

add
```
gem 'omniauth-facebook'
gem 'settingslogic'      # 管理金鑰
```
to `Gemfile`，and then `bundle install`

然後專案裡多了一個`Gemfile.lock`檔

create `app/models/settings.rb`

```
class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env
end
```

and then create `config/application.yml`

```
defaults: &defaults
  app_name: "demotest"
  facebook_app_id: "自己申請的key"
  facebook_secret: "自己申請的key"

development:
  <<: *defaults
  domain: "http:/localhost:3000" #最後 "/" 要拿掉

test:
  <<: *defaults

production:
  <<: *defaults
```

and then fix `MuCat_v1/.gitignore`

```
...
...

# Ignore all logfiles and tempfiles.
/log/*
!/log/.keep
/tmp

# Ignore application.yml
/config/application.yml
```

如此一來，git 就不會把這個檔案放進版本管理裡面

來測試一下能不能work，所以來把該專案上傳到GitHub
