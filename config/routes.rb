Rails.application.routes.draw do
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
  resources :items, only: [:new, :index, :show, :edit, :update]
  end
end
