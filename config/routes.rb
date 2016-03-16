Rails.application.routes.draw do
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  resources :training_courses, only: [:index, :show] do
    member do
      get :print
    end
    resources :journals, only: [:index]
    resources :student_feedbacks, only: [:new, :edit, :update, :show]
    resources :appraises, only: [:index, :new, :create, :edit, :update] do
      collection do
        get :list
      end
    end
    resources :course_resources, only: :index do
      member do
        get :download
      end
    end
  end
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
  resources :materials, only: [:index] do
    collection do
      get :list
    end
    member do
      get :download
    end
  end
  resources :notifications, only: [:show, :index] do
    member do
      get :download
    end
  end
  resources :user, only: [:update] do
    collection do
      get :my
      get :journal
      get :work
      get :message
      get :course
      get :end_course
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

  # 教学设计比武大赛
  resources :competitions

  get 'home/index'

  root "reports#index"
  resources :reports, path: "/", only: [] do
    collection do
      get :contact
      get :business
      get :info
      get :activity
      get :teaching
    end
  end
  #mount ChinaCity::Engine => '/china_city'
  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: 'admins/registrations' }
  namespace :admin_panel do
    devise_for :admins, controllers: { sessions: "admins/sessions", registrations: 'admins/registrations' }
    root "home#index"
    resources :users, only: [:index, :edit, :update, :show]
    resources :notifications do
      resources :training_courses
    end
    resources :manager_feedbacks, only: [:show] do
      collection do
        get :list
      end
    end
    resources :appraises, only: [:show] do
      collection do
        get :list
      end
    end
    resources :student_feedbacks, only: [:show] do
      collection do
        get :list
      end
    end
    resources :admin_user_tasks, only: [:edit, :update] do
      collection do
        get :list
      end
    end
    resources :todos
    resources :user_training_courses, only: :show do
      collection do
        get :list
      end
      resources :journals, only: [:index, :show]
    end
    resources :training_courses do
      collection do
        get :list
        get :list_by_school
        get :list_by_teacher
      end
      member do
        get :detail
      end
      resources :course_resources do
        member do
          get :download
        end
      end
      resources :manager_feedbacks
      resources :tasks, only: [:index]
      resources :user_training_courses, only: [:index, :edit, :update] do
        member do
          patch :disapplied, :applied
          post :disapplied, :applied
          get :add
          patch :added
          post :added
          post :delete, :restore
          patch :delete, :restore
        end
        collection do
          patch :update_multiple
          post :update_multiple
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
      collection do
        get :list
      end
      resources :user_tasks, only: [:index, :show] do
        member do
          get :download
        end
        collection do
          get :unsubmit_users
        end
      end
    end

    resources :user_tasks, only: :show do
      collection do
        get :list
      end
      resources :admin_user_tasks
    end
    resources :journals do
      collection do
        get :list
      end
    end
    resources :teachers
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
    resources :materials do
      member do
        get :download
      end
    end
    resources :activities
    resources :system
  end
end
