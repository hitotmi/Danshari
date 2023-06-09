Rails.application.routes.draw do
  # 顧客用
  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲスト用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  namespace :admin do
    resources :users,  only: [:index, :show, :edit, :update] do
      get 'counseling_posts_index' => 'users#counseling_posts_index'
      get 'post_comments_index' => 'users#post_comments_index'
    end
    resources :counseling_posts,  only: [:index, :show, :destroy] do
      resources :post_comments, only: :destroy
    end
    resources :post_comments, only: [:index, :show]
  end

  scope module: :public do
    root :to => 'homes#top'
    resources :users, only: [:show, :edit, :update] do
      get    'withdraw_confirm'  =>  'users#withdraw_confirm'
      patch  'withdraw'          =>  'users#withdraw'
    end
    resources :counseling_posts do
      resource :favorites, only: [:create, :destroy]
      resource :votes, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy] do
        resource :good_comments, only: [:create, :destroy]
      end
    end
    get "ranking" => "users#ranking"
    resources :notifications, only: [:index, :destroy] do
      post :mark_read, on: :member
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
