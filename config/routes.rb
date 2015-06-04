Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  mount ChinaCity::Engine => '/china_city'
end
