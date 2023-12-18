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
    resources :users, only: [:index, :show] do
      member do
        patch :enable
        patch :disable
      end
    end
    resources :comments, only: [:index, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get "search" =>"searches#search"
    get "search_tag" => "searches#search_tag"
    get "/about" =>"homes#about"
    resources :users, only: [:show, :edit, :update] do
      resources :bookmarks, only: [:index, :create, :destroy]
      resources :comments, only: [:index]
      resources :posts, only: [:index]
      resource :relationships, only: [:create, :destroy]
      collection do
        patch :disable
      end
      member do
        get :bookmarks
        get :comments
        get :follows, :followers
      end
    end
    resources :posts, except: [:edit, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
    end
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
end
