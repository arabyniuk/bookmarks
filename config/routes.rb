require 'subdomain'
Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :links
  resources :categories

  get '*path', to: 'links#obtain_folder_path', constraints: lambda { |r| r.subdomain != "tweet" }

  constraints(Subdomain) do
    get '/', to: 'links#obtain_folder_path'
    get '*path', to: 'links#obtain_folder_path'
  end

  constraints(subdomain: 'tweet') do
    resources :twitter
  end

  get '*path', to: 'twitter#index', constraints: { subdomain: 'tweet' }
  get '/', to: 'twitter#index', constraints: { subdomain: 'tweet' }

  # You can have the root of your site routed with "root"
  root 'links#index'

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
