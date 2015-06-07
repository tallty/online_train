Rails.application.routes.draw do

  get 'train/notice_index'

  get 'train/notice_info'

  get 'train/apply_index'

  get 'train/apply_info'

  captcha_route
  
  get 'user/center'

  devise_for :users

  get 'project/about'

  get 'project/background'

  root "home#index"
  mount ChinaCity::Engine => '/china_city'
end
