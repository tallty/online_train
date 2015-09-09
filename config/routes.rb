Rails.application.routes.draw do
  resources :training_courses, only: [:index, :show]
  resources :user_training_courses, only: [:create]
  resources :user_messages, only: [:destroy] do
    member do
      get :read
    end
  end
  resources :reports do
    collection do
      get :building
      get :home
      get :list
    end
  end

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

  resources :journals, only: [:new, :create, :edit, :update]

  resources :user_tasks do
    member do
      get :download
    end
  end

  devise_for :users

  resources :projects, only: :index
  resources :training_bases, only: :index
  resources :china_germany, only: :index

  get 'home/index'

  root "reports#index"
  #mount ChinaCity::Engine => '/china_city'
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  namespace :admin_panel do
    root "home#index"
    resources :notifications do
      resources :training_courses
    end
    resources :training_courses do
      collection do
        get :list
      end
      resources :user_training_courses, only: [:index, :edit, :update] do
        member do
          patch :disapplied, :applied
          post :disapplied, :applied
        end
      end
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
    resources :user_training_courses do
      collection do
        get :list
      end
    end
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
