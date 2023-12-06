Rails.application.routes.draw do
  #顧客側
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #管理者側
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :update]
    resources :comments, only: [:index, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get "search" =>"searches#search"
    get "/about" =>"homes#about"
    resources :users, only: [:show, :edit, :update] do
      collection do
        patch :withdrawal
      end
    end
    resources :posts, except: [:edit, :update]
    resources :bookmarks, only: [:index, :create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :watch_lists, only: [:index, :create, :destroy]
  end
end
