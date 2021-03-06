Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  namespace :tweets do
    resources:searches, only: :index
  end
  resources :tweets do               #  only: [:index, :new, :create ,:destroy, :edit, :update ,:show] 
    resources :comments, only: :create
    # collection do 
    #   get 'search'
    # end
  end
  # 「tweets」というパスをクライアントがクリックすると 「tweets」コントローラーが「index」という処理を行う。
  resources :users, only: :show   # /users/:idのパスでアクセスした際にusers_controller.rbのshowアクションを呼ぶルーティングが設定
end
