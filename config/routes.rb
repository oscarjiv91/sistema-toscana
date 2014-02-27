Sistema::Application.routes.draw do

  get "client_receipts/new"
  get "client_receipts/create"
  get "client_current_account/index"
  get "client_current_account/show"
  resources :clients do
    resources :client_phones
    resources :client_current_accounts
    collection do
        get :overdue_payments
    end
  end



  resources :user_groups

  resources :users do
    collection do
      get 'signin', :to => "users#signin"
    end
  end

  get "client_bill/new" => "client_bill#new"
  post "client_bill/save"
  post "client_bill/save_payment_plan"
  get "post/save"

  post "client_bill/add_to_temp"
  get "client_bill/add_to_temp"
  post "client_bill/delete_row"
  get "client_bill/delete_row"
  get "client_bill/suggestions"
  get "client_bill/suggestions_client"
  get  "client_bill/show/:id/" => "client_bill#show_details"
  get "client_bill/index"
  get "client_bill/payment_plan/:id/" =>"client_bill#payment_plan", as: "payment_plan"


  get "supplier_bill/suggestions"
  get "supplier_bill/index"
  post "supplier_bill/add_to_temp"
  get "supplier_bill/add_to_temp"
  get  "supplier_bill/show/:id/" => "supplier_bill#show_details"

  post "supplier_bill/delete_row"
  get "supplier_bill/delete_row"

  post "supplier_bill/save"
  get "supplier_bill/new"
  get "supplier_bill/save"

  get "client_receipts/suggestions_client"
  get "client_receipts/get_accounts"
  post "client_receipts/create"
  delete "client_receipts/destroy/:id", to: "client_receipts#destroy", as: "receipt_destroy"

  resources :suppliers do
      resources :salesmen
  end

  resources :product_data

  resources :products

  resources :ivas

  resources :categories

  resources :supplier_bill_head, :controller => "supplier_bill"
  resources :client_bill_head, :controller => "client_bill"

  # Sessions and Users
  resources :sessions, only: [:new, :create, :destroy]
  get '/sessions/new', to: 'sessions#new', as: "signin"
  match '/signin',  to: 'sessions#new',         via: 'get'
  get '/sessions/destroy', to: 'sessions#destroy'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'products#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
