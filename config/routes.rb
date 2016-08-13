Rails.application.routes.draw do


  devise_for :users, :controllers => { registrations: 'users/registrations' }
  as :user do
    get 'users', :to => 'admin/products#index', :as => :user_root
  end
  get '/cart' => 'orders#index'
  get '/cart/clear' => 'orders#clearCart'
  get '/cart/:id' => 'orders#add'
  get '/cart/remove/:id' => 'orders#remove'
  get '/submittedordersession/clear' => "orders#clearOrderSession"

  # vanity routes
  get '/mystore' => 'admin/products#index' # url for merchants
  get '/shop' => 'products#index' # url for public shopping
  get '/update' => 'admin/articles#index'

  get '/new_subscriber' => 'email_digests#new_subscriber'
  resources :email_digests

  get 'orders/customer_details_form'
  get 'orders/payment_form'
  get 'orders/confirmation'
  resources :orders, :except => [:show] do
    member do
      patch :create_customer_details
      put :create_customer_details
      patch :create_payment
      put :create_payment
    end
  end

  root 'articles#cross_country'

  get 'infos/js_enabled'
  get 'infos/terms'

  get 'infos/about'

  get 'articles/cross_country'

  get 'products/hard_goods'
  get 'products/clothing'
  get 'products/waxing'
  get 'products/accessories'
  get 'products/all_products'
  get 'products/merchants'


  resources :products, :only => :index
  get '/shop/:slug', controller: 'products', action: 'store'

  resources :articles, :except => [:edit, :update, :destroy]

  resources :teams
  get 'teams/team'

  get '/merchapp/clear' => 'merchant_applications#clearApp'
  resources :merchant_applications

  get '/complaintsubmit/clear' => 'complaints#clearComp'
  resources :complaints

  resources :contacts
  get 'contacts/team'

  get 'track_orders/my_order'
  get 'track_orders/track'
  get 'trackmyorder/clear' => "track_orders#clear_track_order"
  get 'trackmyorder/tryagain' => "track_orders#try_again"

  resources :user_feedback_answers, :except => [:index, :show]

  namespace :admin do
    get 'products/hard_goods'
    get 'products/clothing'
    get 'products/waxing'
    get 'products/accessories'
    get 'all_orders/merchants'
    get 'all_orders/rep'

    # stripe account routes
    get 'account' => "stripe_accounts#account"
    get 'create_account' => "stripe_accounts#create_account"
    get 'stripe_accounts/new_stripe_account'
    get 'stripe_accounts/edit_account'
    get 'verify_account' => 'stripe_accounts#verify_account'
    get 'update_company_details' => 'stripe_accounts#update_company_details'
    get 'update_banking' => 'stripe_accounts#update_banking'


    resources :products
    resources :articles, :except => [:show]
    resources :all_orders
    resources :orders
    resources :product_categories
    resources :user_feedbacks, :except => [:edit, :update, :destroy, :create, :new]
    get 'email_digests/index'
    get 'email_digests/new_digest'
    get 'email_digests/send_digest' => "email_digests#send_digest"
    get 'articles/advertise'
    get 'articles/about'
    get 'articles/contact'
    get 'contacts/contact'
    get 'teams/team'
  end

end
