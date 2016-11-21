Rails.application.routes.draw do
                                 # 第一層：發表文章、編輯文章
  resources :learningnotes       # 學習資源
  resources :posts               # 實驗室公告
  resources :honors              # 榮譽榜
  resources :users               # 實驗室成員資料
  resources :professorworks      # 教授的著作

  devise_for :users              # 登入系統
  devise_for :managers

  get 'welcome/index'            # 首頁
  root 'welcome#index'

  namespace :dashboard do        # 實驗室成員：編輯個資、
                                 #           查看該帳號發表過什麼文章，點選文章後進入第一層觀看文章，並且編輯之
    resources :learningnotes
    resources :posts
    resources :honors
    resources :users

    namespace :admin do          # 網站管理員：上線的版本要把admin改成亂碼
      resources :users           # 刪除實驗室成員的權限
      resources :professorworks  # 教授的著作
    end
  end
end
