Rails.application.routes.draw do

  namespace :public do
    get 'genres/show'
  end
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# scope module: 'public' do
#     root 'homes#top'
#     resources :items, only: [:show, :index]
#     get 'about' => 'homes#about'
#   end


# namespace :public do
# resources :genres, only: [:show]
#   patch 'customers/withdraw' => 'customers#withdraw', as: 'customers_withdraw'
#   get 'show' => 'customers#show'
#   get 'customers/edit' => 'customers#edit'
#   patch 'update' => 'customers#update'
#   get 'quit' => 'customers#quit'
#   get 'orders/about' => 'orders#about', as: 'orders_about'
#   get 'orders/complete' => 'orders#complete'
#   resources :orders, only: [:create, :new, :index, :show]
#   resources :cart_items, only: [:index, :create, :update, :destroy]
#   delete 'cart_items' => 'cart_items#all_destroy', as: 'all_destroy'
#   resources :shipping_addresses, only: [:index, :create, :destroy, :edit, :update]
#   end

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
# namespace :admin do
#   root :to => 'homes#top'
#   resources :customers, only: [:index, :edit, :update, :show]
#   resources :genres, only: [:index, :create, :edit, :update]
#   resources :items, only: [:show, :index, :new, :create, :edit, :update]
#   resources :orders, only: [:index, :show, :update]
#   resources :order_details, only: [:update]
#   end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 namespace :admin do
    resources :orders, only: [:show, :update]
    get "/" => "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :create, :new, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]
    get "/search" => "items#search"
  end
  scope module: :public do
    resources :shipping_addresses, only: [:index, :create, :destroy, :edit, :update]
    get "/customers/unsubscribe" => "customers#unsubscribe"
    patch "/customers/withdraw" => "customers#withdraw"
    resource :customers, only: [:show, :update, :edit]
    post "/orders/confirm" => "orders#confirm"
    get "/orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :create, :show, :index]
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resources :items, only: [:index, :show]
    root "homes#top"
    get "/about" => "homes#about"
    get "/search" => "items#search"
  end

end
