Rails.application.routes.draw do

  get 'train/notice_index'

  get 'train/notice_info'

  get 'train/apply_index'

  get 'train/apply_info'


  resources :user, only: [:update] do
    collection do
      get :center
      get :journal
      get :work
      get :message1
      get :message2
      get :course
    end
  end

  devise_for :users

  get 'project/about'

  get 'project/background'

  root "home#index"
  #mount ChinaCity::Engine => '/china_city'
  devise_for :admins, :controllers => { :sessions => "admin_panel/sessions" }
  namespace :admin_panel do
    root "home#index"
  end
end
