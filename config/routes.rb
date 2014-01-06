InvictusSiteV2::Application.routes.draw do
  # Main welcome index
  root 'static_pages#index_main', via: 'get'
  # Static Pages
  match '/revisions', to: 'static_pages#git_revisions', via: 'get'
  match '/revisions/web', to: 'static_pages#git_revisions_web', via: 'get'
  match '/revisions/vanilla', to: 'static_pages#git_revisions_vanilla', via: 'get'
  match '/revisions/modded', to: 'static_pages#git_revisions_modded', via: 'get'
  match '/downloads', to: 'static_pages#index_downloads', via: 'get'
  match '/about', to: 'static_pages#index_about', via: 'get'
  # Send devise to our
  devise_for :users, :controllers => {
    registrations: "users/registrations", 
    passwords: "users/passwords", 
  }
  # Users
  resources :users

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
