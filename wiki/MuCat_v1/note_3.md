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
