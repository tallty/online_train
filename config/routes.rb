Rails.application.routes.draw do
  get 'train/notice_index'

  get 'train/notice_info'

  get 'train/apply_index'

  get 'train/apply_info'

  captcha_route
  devise_for :users
  root "home#index"
  mount ChinaCity::Engine => '/china_city'
end
