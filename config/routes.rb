Rails.application.routes.draw do

  namespace :wechat do
    resources :tours, only: [:index, :show]
    resources :days, only: [:show]
    get 'api', to: 'api#check'
    post 'api', to: 'api#message'

    resources :routes, only: [] do
      resources :departures, only: [:index]
    end
  end

  resources :tours do
    resources :routes, shallow: true do
      resources :days, shallow: true
      resources :departures, shallow: true
    end
    
    resources :slides, shallow: true
    resources :high_lights, shallow: true
  end
  

  match '/japan', to: 'tours#show', via: 'get'
  match '/maoxian88', to: 'tours#maoxian88', via: 'get'
  match '/maoxian_vinery', to: 'tours#maoxian_vinery', via: 'get'
  match '/au13', to: 'tours#au13', via: 'get'
  match '/west_au', to: 'tours#west_au', via: 'get'

  match '/ax12', to: 'tours#ax12', via: 'get'
  match '/ax13', to: 'tours#ax13', via: 'get'
  match '/ax16', to: 'tours#ax16', via: 'get'
  match '/sample', to: 'tours#sample', via: 'get'

  match '/huang', to: 'tours#huang', via: 'get'

  match '/round', to: 'tours#round', via: 'get'

  match '/tour/calendar', to: 'tours#calendar', via: 'get' 
  

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
