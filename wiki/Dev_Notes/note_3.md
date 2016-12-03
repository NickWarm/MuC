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

~~然後專案裡多了一個`Gemfile.lock`檔~~

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
  domain: "http:/localhost:3000" # 必須要跟 facebook 上的 website 網址一樣，但是尾端不放『/』

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

來測試一下能不能work，所以來把該專案上傳到GitHub，恩......fail

![](../../wiki/img/settinglogic_fail?.png)

經過測試後，我知道原因了，因為我最初的構想是在MuWeb這專案有不同版本的實驗室網站，後來發現這樣無法用settingslogic

>如何在MAC使用`tree`指令，請見[mac tree命令 - 破男孩 - 博客园](http://www.cnblogs.com/ayseeing/p/4097066.html)
>
>我個人習慣下`tree -d`，這樣比較不會有太多資訊

最後決定把資料夾結構改變，這專案就不再更動了，開一個新專案，然後把MuCat_v1的東西複製過去  ->  成功

上傳到GitHub的專案，可以看到`config`資料夾裡沒有`application.yml`這個檔案

## 插曲

先前測試時，在GitHub開了一個專案也叫MuCat_v1，然後把它砍掉

接著把重新弄好的專案一樣命名為MuCat_v1，然後要用`git remote add github git@github.com:NickWarm/MuCat_v1.git`時，就一直失敗

最後是看到這篇[Removing a remote - User Documentation](https://help.github.com/articles/removing-a-remote/)，我先在此專案下指令`git remote -v`

```
nicholas at NicholasdeMacBook-Pro.local in ~/Desktop/mucat_v1 on dev
$ git remote -v
github	git@github.com:NickWarm/MuCat.git (fetch)
github	git@github.com:NickWarm/MuCat.git (push)
```

然後再下指令`git remote rm github`，之後再下一次`git remote -v`就可以看到remote已經空了

```
nicholas at NicholasdeMacBook-Pro.local in ~/Desktop/mucat_v1 on dev
$ git remote -v
```

於是我就可以成功`git remote add github git@github.com:NickWarm/MuCat_v1.git`，然後再`git push github dev`了

## 修正FB developer ID、密碼的儲存方式

一開始以為只能用settingslogic才不會暴露你的FB developer的ID、密碼，後來臨摹ALPHA camp體系的login寫法發現，只要寫在yml檔，然後在`.gitignore`裡設定好，讓該檔案不會存到git裡去即可

create `config/facebook.yml` and `config/facebook.yml.example`

```
development:

  facebook_app_id: "申請facebook app 拿到的 app ID"

  facebook_secret: "申請facebook app 拿到的 app secret"

```

```
development:

  facebook_app_id: "申請facebook app 拿到的 app ID"

  facebook_secret: "申請facebook app 拿到的 app secret"

```

fix `config/initializers/devise.rb`
- ref：[FUSAKIGG/config/initializers/devise.rb](https://github.com/lustan3216/FUSAKIGG/blob/master/config/initializers/devise.rb)

```
fb_config = Rails.application.config_for(:facebook)
config.omniauth :facebook, fb_config["facebook_app_id"], fb_config["facebook_secret"],
                :scope => 'public_profile, email', :info_fields => 'email, name'
```

and then add to `.gitignore`
```
# Ignore facebook app config
/config/facebook.yml
```

接著刪除原本sdlong體系settingslogic的設定

edit `.gitignore`, and then delete

```
# Ignore application.yml
/config/application.yml
```

and then delete `config/application.yml`

and then delete `app/models/settings.rb`

edit `Gemfile` , 註解掉
```
gem 'settingslogic'      # 管理金鑰
```
and then `bundle install`

delete `Gemfile.lock`

## 修正使用者情境

原本的想法
- 登入按鈕所有人都看得到
- 但是只有實驗室成員能登入

但是這樣很不合邏輯，看得到登入頁面卻無法註冊

修正後的使用者情境
- 登入註冊頁面不公開
- 後台與登入頁面寫入`robots.txt`



# 申請Facebook developer
