SpeakingCalendar::Application.routes.draw do

  namespace :admin do
    resources :events
    resources :users

    root to: "events#index"
  end

  get '/' ,:to => 'users#show', :constraints => lambda { |request| request.session[:user_id] }

  root :to => 'users#new'

  resources :users, except: [:destroy, :delete, :index] do
    collection do
      get 'events/new' => 'events#new'
      root :to => "users#new"
    end
  end


  resources :o_auth_sessions, only: [:create] do
    collection do
      post 'complete_registration', as: "complete_registration"
      get 'register'
    end

  end
  get "/auth/:provider/callback" => "o_auth_sessions#create"

  resources :sessions, only: [:new,:create]
  get 'sessions/destroy'

  resources :events

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
