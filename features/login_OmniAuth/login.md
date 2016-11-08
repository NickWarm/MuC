# 登入系統

**sign in**、**Log in** 都是「登入」

**sign up**、**refister** 都是「註冊」

需要實驗室 **現在成員** 與 **畢業成員** 每個人的信箱，一個一個幫他們註冊帳號

定案：MuCat_v1只實作綁臉書登入與註冊的功能

# 學習順序

#### Step.1 基本設定
- [Rails Screencast #1 - Criando autenticação com o Facebook! (Devise + Omniauth)](https://youtu.be/BeJpFQHm4A8?t=132)
  - facebook developer申請
    - [Facebook Userlogin für Ruby On Rails mit OmniAuth](https://youtu.be/yibLfNXoY5M?t=57)，後面不用看，那是不用devsie的做法。
    - [Rails 新手村-3. Facebook 自動登入功能 « sdlong's Blog](http://sdlong.logdown.com/posts/207194-rails-newbie-3)
  - [OmniAuth: Overview · plataformatec/devise Wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview)
    - [Rails 新手村 - Facebook 自動登入功能 « sdlong's Blog](http://sdlong.logdown.com/posts/207194-rails-newbie-3)
    - [Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記](http://paulchia.logdown.com/posts/365026)
    - [Step.5 後台的controller · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.5-%E5%BE%8C%E5%8F%B0%E7%9A%84controller)
    - [Step.2 路由設定 · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.2-%E8%B7%AF%E7%94%B1%E8%A8%AD%E5%AE%9A)
  - [Ruby on Rails - 整合 Devise 實作 Facebook 登入機制 « 魚人筆>記](http://fisherliang.logdown.com/posts/301654-ruby-on-rails-real-facebook-login-mechanism)
- [Setting up User Authentication in Rails (Devise, Facebook,Twitter,Google) – CodeShutters](https://codeshutters.wordpress.com/2016/03/17/setting-up-user-authentication-in-rails-devise-facebooktwittergoogle/)
  - 這篇有教，用devise複數設定使用google與facebook帳號登入
  - **這篇不錯**
  - 還有包好範例，真的太佛心：[shubhangisingh/social_auth - GitHub](https://github.com/shubhangisingh/social_auth)
  - 看以下兩篇，搜尋「token」，可以看到Google對token的處理比facebook複雜許多
    - [Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記](http://paulchia.logdown.com/posts/365026)
    - [Devise使用Google實作登入 « NicLin Dev](http://blog.niclin.tw/posts/628482--devise-used-google-implements-login)
      - [Rails 新手村 - Facebook 自動登入功能 « sdlong's Blog](http://sdlong.logdown.com/posts/207194-rails-newbie-3)
      - [Step.5 後台的controller · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.5-%E5%BE%8C%E5%8F%B0%E7%9A%84controller)
      - [Step.2 路由設定 · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.2-%E8%B7%AF%E7%94%B1%E8%A8%AD%E5%AE%9A)

> 筆記1

一開始在研究，怎樣讓facebook與google login並存

比較閱讀這三篇文章後，應該有辦法解了
- [Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記](http://paulchia.logdown.com/posts/365026)
- [Devise使用Google實作登入 « NicLin Dev](http://blog.niclin.tw/posts/628482--devise-used-google-implements-login)
- [Setting up User Authentication in Rails (Devise, Facebook,Twitter,Google) – CodeShutters](https://codeshutters.wordpress.com/2016/03/17/setting-up-user-authentication-in-rails-devise-facebooktwittergoogle/)


先看這兩篇，拉到最底下
- [Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記](http://paulchia.logdown.com/posts/365026)
- [Devise使用Google實作登入 « NicLin Dev](http://blog.niclin.tw/posts/628482--devise-used-google-implements-login)

**1. 傳個function進到path裡去**

可以看到
```
Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記

<%= link_to("Facebook Login", Settings.domain + user_omniauth_authorize_path(:facebook)) %>

---------------
Devise使用Google實作登入 « NicLin Dev

<%= link_to "Sign in with Google", user_omniauth_authorize_path(:google_oauth2) %>
```

我們可以看到，登入時都是透過`user_omniauth_authorize_path()`分別傳入`:facebook`與`:google_oauth2`

**2. 傳進去的function是如何定義的**

app/controllers/users/omniauth_callbacks_controller.rb
```
Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記

def facebook
  # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
    end
end

---------------

Devise使用Google實作登入 « NicLin Dev

def google_oauth2

  @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

  if @user.persisted?
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
    sign_in_and_redirect @user, :event => :authentication
  else
    session["devise.google_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_url
  end
end
```

我們可以看到`User model`分別調用了`from_omniauth`與`find_for_google_oauth2`使得我們能夠抓omniauth裡的資料，來尋找omniauth裡是否存在與facebook帳號相同的e-mail

**3. 定義「尋找omniauth裡是否存在與facebook帳號相同的e-mail」**

於是我們回去看`User model`

app/models/user.rb
```
Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記

def self.from_omniauth(auth)

    #Rails.logger.info auth.inspect
    #Rails.logger.info "========="  #這是如果有錯的話可以用來檢查
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

        user.email = auth.info.email

        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name

        user.image = auth.info.image
    end

  end
---------------
Devise使用Google實作登入 « NicLin Dev

def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20]
        )
      end
    end
  end
```

> 筆記1 end


#### Step.2 安全性設定
- [Rails 新手村 - Facebook 自動登入功能 « sdlong's Blog](http://sdlong.logdown.com/posts/207194-rails-newbie-3)
  - [Rails 4 + SettingsLogic + Googl 製作短網址功能 « 赫謙小天地](http://hechien.logdown.com/posts/2014/03/08/rails-4-settingslogic-googl-production-short-url-functionality)
  - [Settingslogic插件 | Ruby迷](http://rubyer.me/blog/551/)
  - [xdite/auto-facebook - GitHub](https://github.com/xdite/auto-facebook)
- [Rails 新手村 - FB會員登入API--PLga « 阿嘎筆記](http://paulchia.logdown.com/posts/365026)
- [Rails 新手村 - google sign_in api----PLGa « 阿嘎筆記](http://paulchia.logdown.com/posts/370630)

#### Step.3 production時的設定

robots.txt

dalli

# 學習資源

#### 影片：facebook
- [Rails Screencast #1 - Criando autenticação com o Facebook! (Devise + Omniauth)](https://youtu.be/BeJpFQHm4A8?t=132)
  - 中間Facebook API的申請，可以看[Facebook Userlogin für Ruby On Rails mit OmniAuth](https://www.youtube.com/watch?v=yibLfNXoY5M)

#### 文章：facebook
- [Ruby on Rails - 整合 Devise 實作 Facebook 登入機制 « 魚人筆>記](http://fisherliang.logdown.com/posts/301654-ruby-on-rails-real-facebook-login-mechanism)
- [使用Omniauth整合facebook及google註冊認證 – 酷思小魏の IT筆記](https://blog.coolsea.net/archives/153)
  - 這篇沒有用devise，不同於官方的設定
- [Devise 使用 Facebook 註冊與登入 « 像貓一樣懶](http://georgiowan.logdown.com/notes/733856/rails-devise-using-facebook-signup-login)
- [透過OmniAuth使用FB帳號登入 « Kuro_Sean's Blog](http://kuro-sean-blog.logdown.com/posts/712195-via-omniauth-fb-account-login)
- [Devise 使用 Facebook 註冊與登入 | 新樂街口的三角窗](https://oawan.me/2016/rails-devise-using-facebook-signup-login/)
- [Rails User 建立-1 (Devise + Omniauth-facebook + facebook api) ~ 史蒂芬.陳的碎碎念](http://stevenchentw.blogspot.tw/2016/04/rails-devise-omniauth-facebook-facebook.html)
- [Devise + Omniauth 的 Facebook 登入範例 - 黃金俠](http://rubyist.marsz.tw/blog/2012-02-11/devise-omniauth-for-facebook-login/)
- [OmniAuth: Overview · plataformatec/devise Wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview)
  - devise官方wiki就有教如何串devise與omniauth-facebook
  - 因為實驗室網站拆成實驗室成員與網站管理員。最初構想是實驗室成員與網站管理員都能用臉書帳號登入
  - 不過讀這篇才知道 **傳統devise 只能讓一個model使用**，若想讓複數model使用，要閱讀[OmniAuth with multiple models · plataformatec/devise Wiki](https://github.com/plataformatec/devise/wiki/OmniAuth-with-multiple-models)這篇
- [Setting up User Authentication in Rails (Devise, Facebook,Twitter,Google) – CodeShutters](https://codeshutters.wordpress.com/2016/03/17/setting-up-user-authentication-in-rails-devise-facebooktwittergoogle/)
  - 這篇有教，用devise複數設定使用google與facebook帳號登入
- [陳雲濤的部落格: ROR - FB會員登入APP -- YTChen](http://violin-tao.blogspot.tw/2015/05/ror-fbapp-ytchen.html)

#### 影片：google
- [ROR Workshop: SSO-Devise and OmniAuth](https://youtu.be/uYFkSsmuZuw?t=381)
  - 這篇是在講google登入設定

#### 文章：google
- [devise和google oauth實作登入 – 酷思小魏の IT筆記](https://blog.coolsea.net/archives/347)
- [Devise使用Google實作登入 « NicLin Dev](http://blog.niclin.tw/posts/628482--devise-used-google-implements-login)
- [Rails 新手村 - google sign_in api----PLGa « 阿嘎筆記](http://paulchia.logdown.com/posts/370630)

#### 不用devise的做法
- [Facebook Userlogin für Ruby On Rails mit OmniAuth - YouTube](https://www.youtube.com/watch?v=yibLfNXoY5M)
- [Codeplace | Login with Social Networks using Omniauth (Ruby on Rails) - Part I - YouTube](https://www.youtube.com/watch?v=11BInedaQSo)
- [Codeplace | Login with Social Networks using Omniauth (Ruby on Rails) - Part II - YouTube](https://www.youtube.com/watch?v=1yRvsI34Ysw)
  - 這系列有教用`GitHub登入`
  - [intridea/omniauth-github: GitHub strategy for OmniAuth](https://github.com/intridea/omniauth-github)

#### session
- [Ruby on Rails (30) - Session - iT 邦幫忙](http://ithelp.ithome.com.tw/articles/10161751)
- [Ruby on Rails 實戰聖經 | Action Controller - 控制 HTTP 流程 - Session](https://ihower.tw/rails/actioncontroller.html#sec7)
- [Session - Action Controller 概覽 — Ruby on Rails 指南](http://rails.ruby.tw/action_controller_overview.html#session)
- [Login session 觀念 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/login-session/321/2)
- [session / cookie 解釋 - 求救 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/session-cookie/380/3)
  - 上production必上 **dalli**
  - [RailsFun tw 新手教學 day7 HD « tienshunlo's Blog](http://tienshunlo-blog.logdown.com/posts/711620-railsfun-tw-day7-novice-teaching-hd)，搜尋「dalli」
  - [RailsFun.tw 新手教學 day7 HD](https://youtu.be/V7rYF0VR8SQ?t=7760)
  - [Rails memcache lock (dalli) - 教學 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/rails-memcache-lock-dalli/490)

記住登入的狀態、記住使用者購物車的內容等等，都是用Session實作出來的。



#### Omniauth
- [Rails 新手村-3. Facebook 自動登入功能 « sdlong's Blog](http://sdlong.logdown.com/posts/207194-rails-newbie-3)
  - [Rails 4 + SettingsLogic + Googl 製作短網址功能 « 赫謙小天地](http://hechien.logdown.com/posts/2014/03/08/rails-4-settingslogic-googl-production-short-url-functionality)
  - [Settingslogic插件 | Ruby迷](http://rubyer.me/blog/551/)
  - [Settingslogic Gem簡介- Oh!Coder](http://ohcoder.com/blog/2015/05/10/settingslogic/)
- [Devise + Omniauth 的 Facebook 登入範例 - 黃金俠](http://rubyist.marsz.tw/blog/2012-02-11/devise-omniauth-for-facebook-login/)
- [omniauth/omniauth - GitHub](https://github.com/omniauth/omniauth)
- [mkdynamic/omniauth-facebook - GitHub](https://github.com/mkdynamic/omniauth-facebook)
- [zquestz/omniauth-google-oauth2 - GitHub](https://github.com/zquestz/omniauth-google-oauth2)


#### omniauth - uid
- [Auth Hash Schema · omniauth/omniauth Wiki](https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema)
- [omniauth wiki - Strategy Contribution Guide - Defining the Callback Phase](https://github.com/omniauth/omniauth/wiki/Strategy-Contribution-Guide#defining-the-callback-phase)
- [OmniAuth: Overview · plataformatec/devise Wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview)
- [mkdynamic/omniauth-facebook: Facebook OAuth2 Strategy for OmniAuth](https://github.com/mkdynamic/omniauth-facebook)
- [zquestz/omniauth-google-oauth2: Oauth2 strategy for Google](https://github.com/zquestz/omniauth-google-oauth2)
[關於OmniAuth::Strategies::Facebook - 雜談 - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/omniauth-strategies-facebook/354)




#### devise
- [Ruby on Rails Devise Tutorial - 4 - YouTube](https://www.youtube.com/watch?v=qY5HccvIuS4)
- [006: Setup User Authentication with Devise - YouTube](https://www.youtube.com/watch?v=zJYuLebl-Js)
- [Step.3 註冊系統與產品圖片 · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.3-%E8%A8%BB%E5%86%8A%E7%B3%BB%E7%B5%B1%E8%88%87%E7%94%A2%E5%93%81%E5%9C%96%E7%89%87)
- [Step.4 models · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.4-models)
- [Step.5 後台的controller · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.5-%E5%BE%8C%E5%8F%B0%E7%9A%84controller)
- [Add Devise for Authentication - How to build a blog & portfolio with Rails 4 - YouTube](https://www.youtube.com/watch?v=-WLPL1AvazE)
  - 這篇有教如何把devise生成的註冊頁改成我們想要的
- [plataformatec/devise - GitHub](https://github.com/plataformatec/devise)
- [OmniAuth: Overview · plataformatec/devise Wiki](https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview)






#### robots.txt
- [Step.5 後台的controller · NickWarm/jccart Wiki](https://github.com/NickWarm/jccart/wiki/Step.5-%E5%BE%8C%E5%8F%B0%E7%9A%84controller)
- [會員與登入系統要點：devise / robots.txt - Rails - Rails Fun!! Ruby & Rails 中文論壇](http://railsfun.tw/t/devise-robots-txt/376)
- [給 Rails Developer 的基本SEO - 好麻煩部落格](http://gogojimmy.net/2013/09/26/basic-seo-for-rails-developer/)，搜尋「robots.txt」
- [jccart/robots.txt at master · NickWarm/jccart](https://github.com/NickWarm/jccart/blob/master/public/robots.txt)
- [有關robots.txt的大小事](https://sibevin.github.io/posts/2015-02-09-164401-robots-txt)
