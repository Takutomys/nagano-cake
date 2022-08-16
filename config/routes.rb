Rails.application.routes.draw do
  namespace :public do
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'
  end
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
        root to: "homes#top"
    get '/about' => "homes#about"
    get 'customer/unsubscribe' => "customers#unsubscribe"
    patch 'customer/withdraw' => "customers#withdraw"
    delete 'cart_items/destroy_all' => "cart_items#destroy_all"
    post 'orders/confirm' => "orders#confirm"
    get 'orders/complete' => "orders#complete"

    resource :customer, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:index, :show, :new, :create]
  end

  namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, only: [:new, :create, :index, :show, :edit, :update]
  resources :customers, only: [:index, :show, :edit]
  resources :orders, only: [:show, :update]
  get "/admin" => "homes#top" , as:'admin_top'
  end
end
