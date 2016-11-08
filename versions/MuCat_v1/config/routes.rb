Rails.application.routes.draw do
  resources :learningnotes   # 學習資源
  resources :posts           # 實驗室公告
  resources :honors          # 榮譽榜
  resources :users           # 實驗室成員資料

  devise_for :users          # 登入系統
  devise_for :managers

  get 'welcome/index'        # 首頁
  root 'welcome#index'

  namespace :dashboard do    # 實驗室成員：新增編輯文章、個資使用
    resources :learningnotes
    resources :posts
    resources :honors
    resources :users

    namespace :admin do      # 網站管理員：上線的版本要把admin改成亂碼
      resources :honors
      resources :users
    end
  end
end
