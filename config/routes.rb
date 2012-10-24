Payroll::Application.routes.draw do
  root :to => 'home#index'
  
  scope 'designation', :as => 'designation' do
    match '' => 'designation#index', :via => :get
    match 'list' => 'designation#list', :as => :list, :via => :get
    match 'new' => 'designation#new', :as => :new, :via => :get
    match 'create' => 'designation#create', :as => :create, :via => :post
    match 'edit(/:id)' => 'designation#edit', :as => :edit, :via => :get
    match 'update(/:id)' => 'designation#update', :as => :update, :via => :post
    match 'delete' => 'designation#destroy', :as => :delete, :via => :post
  end
  
  scope 'employee', :as => 'employee' do
    match '' => 'employee#index', :via => :get
    match 'list' => 'employee#list', :as => :list, :via => :get
    match 'new' => 'employee#new', :as => :new, :via => :get
    match 'create' => 'employee#create', :as => :create, :via => :post
    match 'edit(/:id)' => 'employee#edit', :as => :edit, :via => :get
    match 'update(/:id)' => 'employee#update', :as => :update, :via => :post
    match 'delete' => 'employee#destroy', :as => :delete, :via => :post
  end
  
  scope 'setting', :as => 'setting' do
    match '' => 'setting#index', :via => :get
	  match 'list' => 'setting#list', :as => :list, :via => :get
	  match 'new' => 'setting#new', :as => :new, :via => :get
    match 'create' => 'setting#create', :as => :create, :via => :post
    match 'edit(/:id)' => 'setting#edit', :as => :edit, :via => :get
    match 'update(/:id)' => 'setting#update', :as => :update, :via => :post
    match 'delete' => 'setting#destroy', :as => :delete, :via => :post
  end
  
  scope 'user', :as => 'user' do
    match '' => 'user#index', :via => :get
    match 'list' => 'user#list', :as => :list, :via => :get
    match 'new' => 'user#new', :as => :new, :via => :get
    match 'create' => 'user#create', :as => :create, :via => :post
    match 'edit(/:id)' => 'user#edit', :as => :edit, :via => :get
    match 'update(/:id)' => 'user#update', :as => :update, :via => :post
    match 'delete' => 'user#destroy', :as => :delete, :via => :post
  end
  
  scope 'payroll', :as => 'payroll' do
    match '' => 'payroll#index', :via => :get
    match 'list' => 'payroll#list', :as => :list, :via => :get
    match 'report(/:id(/:month))' => 'payroll#report', :as => :report, :via => :get
  end
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
