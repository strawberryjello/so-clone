Rails.application.routes.draw do
  get '/login', :to => 'users#login', :as => :login
  post '/do_login', :to => 'users#do_login', :as => :do_login
  get '/logout', :to => 'users#logout', :as => :logout
  
  resources :users do
    resources :answers
    resources :questions
    resources :upvotes
    resources :downvotes

    member do
      get :change_password
      post :do_change_password
    end

    collection do
      get :forgot_password
      post :do_forgot_password
    end
  end
  
  resources :questions do
    resources :answers do
      resources :upvotes
      resources :downvotes
    end
    
    resources :tags
    resources :upvotes, :to => :upvote_question, only: [:create]
    resources :downvotes

    member do
      post :untag
    end
  end

  resources :tags do
    collection do
      get :search, :to => 'tags#search'
    end
  end

  root 'questions#index'

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
