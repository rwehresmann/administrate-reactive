Rails.application.routes.draw do
  namespace :admin do
    resources :products
    resources :shops
    resources :sales_points

    root to: "products#index"
  end
end
