Rails.application.routes.draw do
  devise_scope :user do
    # 下面這行，把註冊的預設網址改成http://localhost:3000/lab515/sign_up，一樣上線版要改成不同的網址
    get "/lab515/sign_up" => "devise/registrations#new", as: "new_user_registration"
    get "/lab515/sign_in" => "devise/sessions#new"

    get "/users/sign_up"  => redirect('/')  # 關掉devise原始路由設定
    get "/users/sign_in"  => redirect('/')
  end
                                 # 第一層：發表文章、編輯文章
  resources :notes               # 學習資源
  resources :posts               # 實驗室公告
  resources :honors              # 榮譽榜
  resources :professorworks      # 教授的著作

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }
                                 # 登入系統，實驗室成員資料，只能登入不能註冊
  devise_for :managers

  get 'welcome/index'            # 首頁
  root 'welcome#index'

  namespace :dashboard do        # 第二層：~~上線版要把dashboard改名，不能讓非實驗室成員能進入這頁面~~，
                                 #          其實只要before_action :authenticate_user!即可
                                 #          查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之
    resources :notes
    resources :posts
    resources :honors
    resources :users             # 實驗室成員：編輯個資
                                 #           查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之

    namespace :admin do          # 第三層：上線的版本要把admin改成亂碼
      resources :managers        # 網站管理員
      resources :users           # 刪除實驗室成員的權限
      resources :professorworks  # 教授的著作
    end
  end

  get '*path' => redirect('/')
end
