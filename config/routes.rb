Rails.application.routes.draw do
  scope module: :public do
    get '/' => "homes#top"
    get '/about' => "homes#about"
  end
 devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, only: [:new, :create, :index, :show, :edit, :update]
  resources :customers, only: [:index, :show, :edit]
  resources :orders, only: [:show, :update]
  get "/admin" => "homes#top" , as:'admin_top'
  end
end
