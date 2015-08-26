Rails.application.routes.draw do

  get 'train/notice_index'

  get 'train/notice_info'
  get 'train/work_info'
  resources :training_courses, only: [:index, :show]
  resources :user_training_courses, only: [:create]
  resources :user_messages, only: [:destroy] do
    member do
      get :read
    end
  end
  resources :reports, only: [:index]
  resources :events, only: [:index, :show]
  resources :notifications, only: [:show, :index]
  resources :user, only: [:update] do
    collection do
      get :my
      get :journal
      get :work
      get :message
      get :course
    end
  end
  resources :user_tasks do
    member do
      get :download
    end
  end

  devise_for :users

  get 'project/about'

  get 'project/background'

  root "home#index"
  #mount ChinaCity::Engine => '/china_city'
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  namespace :admin_panel do
    root "home#index"
    resources :training_courses do
      collection do
        get :list
      end
      resources :notifications
      member do
        patch :unchecked, :checked_by_expert, :checked_by_seminar, :checked_by_educator
        post :unchecked, :checked_by_expert, :checked_by_seminar, :checked_by_educator
      end
    end
    resources :tasks do
      member do
        get :download
      end
    end
    resources :user_tasks
    resources :journals
    resources :teachers
    resources :user_training_courses
    resources :user_appraise_trains
    resources :user_teachers
    resources :schools do
      collection do
        get :schools_by_province
      end
    end
    resources :admins do
      collection do
        get :edit_profile
        get :edit_password
        post :update_profile, :update_password
        patch :update_password, :update_password
      end
    end
    resources :training_courses
    resources :events
    resources :activities
    resources :users
    resources :system
  end
end
