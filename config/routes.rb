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
  # Devise
  devise_for :users
  # Users
  resources :users, only: [:index, :edit, :update, :destroy]
  # Post
  resources :posts, path: 'news' do
    # Comments
    resources :comments, only: [:create, :update, :destroy]
  end
  # Send errors to render
  if Rails.env.production?
     get '404', :to => 'application#render_404'
     get '422', :to => 'application#render_500'
     get '500', :to => 'application#render_500'
  end
end
