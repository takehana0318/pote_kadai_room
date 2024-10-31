Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # ユーザーアカウント関連のルーティング
  get 'account', to: 'users#account', as: :user_account
  get 'profile/edit', to: 'users#edit_profile', as: :edit_profile
  patch 'profile', to: 'users#update_profile', as: :update_profile

  # 施設関連のルーティング
  resources :rooms, only: [:index, :show, :new, :create] do
    collection do
      get :search
    end

    # 施設ごとの予約新規作成
    resources :reservations, only: [:new, :create]
  end

  # 予約一覧と予約確認ページ
  resources :reservations, only: [:index, :show]

  # 全ルーム表示用のルート（rootに設定）
  root to: 'rooms#all_rooms'
end

