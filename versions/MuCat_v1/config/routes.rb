Rails.application.routes.draw do
  devise_for :lab_members    # 登入系統
  devise_for :managers

  resources :learningnotes   # 學習資源
  resources :posts           # 實驗室公告
  resources :honors          # 榮譽榜
  resources :lab_members     # 實驗室成員資料



  get 'welcome/index'        # 首頁
  root 'welcome#index'

  namespace :dashboard do    # 實驗室成員：新增編輯文章、個資使用
    resources :learningnotes
    resources :posts
    resources :honors
    resources :lab_members

    namespace :admin do      # 網站管理員：上線的版本要把admin改成亂碼
      resources :honors
      resources :lab_members
    end
  end
end
