Rails.application.routes.draw do
  #get 'scanners/create'

  #get 'scanners/index'

  #get 'scanners/update'

  #Rates
  resources :rates, :defaults => { :format => 'json' }
  get 'rates/product/:code' => 'rates#index_by_product', :defaults => { :format => 'json' }
  get 'rates/bank/:code' => 'rates#index_by_bank'
  #post 'rates/:code', to: 'products#update_by_code', :defaults => { :format => 'json' }
  post 'rates/collection/:rates', to: 'rates#create_from_collection', :defaults => { :format => 'json' }
  #Products
  resources :products, :defaults => { :format => 'json' }
  post 'products/:code', to: 'products#update_by_code', :defaults => { :format => 'json' }
  post 'products/collection/:products', to: 'products#create_from_collection', :defaults => { :format => 'json' }
  #Banks
  resources :banks, :defaults => { :format => 'json' }
  post 'banks/:code', to: 'banks#update_by_code', :defaults => { :format => 'json' }
  post 'banks/collection/:banks', to: 'banks#create_from_collection', :defaults => { :format => 'json' }
  post 'banks/bankProducts/:bankProducts', to: 'banks#set_bank_products', :defaults => { :format => 'json' }

  #Scanner
  resources :scanners, :defaults => { :format => 'json' }
  post 'scanners/user/', to: 'scanners#index_by_user', :defaults => { :format => 'json' }
  post 'scanners/rates_n/user',to: 'scanners#send_rates_notification_by_user', :defaults => { :format => 'json' }
  post 'scanners/rates_n/all',to: 'scanners#send_rates_notification_all', :defaults => { :format => 'json' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
