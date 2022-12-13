Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: "users/sessions" }
  devise_scope :user do
    authenticated do
      root 'members#index', as: :authenticated_root
    end
    unauthenticated do
      root 'members#index', as: :unauthenticated_root
    end
  end

  resources :users do
    resources :settings, only: [:index], module: :users
    resources :avatars, only: [:update], module: :users
  end
  namespace :users do
    resources :passwords, only: [:edit, :update]
  end

  resources :searches, only: [:index]

  resources :committees do
    resources :committee_members, module: :committees
    resources :terms, module: :committees
    resources :ordinances, module: :committees
    resources :resolutions, module: :committees
    resources :members, module: :committees
  end

  resources :members do
    resources :terms, module: :members
    resources :ordinances, module: :members
    resources :resolutions, module: :members
    resources :salary_adjustments, module: :members
    resources :step_increments, module: :members
    resources :service_oaths, module: :members
  end

  resources :resolutions do
    resources :documents, only: [:create, :destroy], module: :resolutions
    resources :sponsors, module: :resolutions
    resources :authors, module: :resolutions
    resources :stages, module: :resolutions
    namespace :authorships, module: :resolutions do
      resources :authors, module: :authorships
      resources :co_authors, module: :authorships
    end
  end

  resources :ordinances do
    resources :documents, only: [:create, :destroy], module: :ordinances
    resources :sponsors, module: :ordinances
    resources :authors, module: :ordinances
    resources :stages, module: :ordinances
    namespace :authorships, module: :ordinances do
      resources :authors, module: :authorships
      resources :co_authors, module: :authorships
    end
  end

  resources :minutes do
    resources :documents, only: [:create, :destroy], module: :minutes
  end

  resources :sp_sessions do
    resources :documents, only: [:new, :create, :destroy], module: :sp_sessions
    resources :committee_reports, only: [:new, :create, :destroy], module: :sp_sessions
    resources :resolutions, only: [:new, :create, :destroy], module: :sp_sessions
    resources :ordinances, only: [:new, :create, :destroy], module: :sp_sessions
    resources :committees, only: [:new, :create, :destroy], module: :sp_sessions
  end
  resources :hearings do
    resources :documents, only: [:new, :create, :destroy], module: :hearings
  end
  resources :meetings do
    resources :documents, only: [:new, :create, :destroy], module: :meetings
  end

  resources :settings, only: [:index]
  
  namespace :settings do
    resources :political_parties
    resources :sp_terms
    resources :positions
    resources :categories
    resources :members, only: [:index]
    resources :committees, only: [:index]
    resources :resolutions, only: [:index]
    resources :ordinances, only: [:index]
    namespace :importers do
      resources :members,              only: [:create]
      resources :committees,           only: [:create]
      resources :ordinances,           only: [:create]
      resources :ordinance_authors,    only: [:create]
      resources :ordinance_sponsors,   only: [:create]
      resources :ordinance_documents,  only: [:create]
      resources :resolutions,          only: [:create]
      resources :resolution_authors,   only: [:create]
      resources :resolution_documents, only: [:create]
      resources :memberships,          only: [:create]
      resources :member_terms,         only: [:create]
    end
    namespace :mergers do
      resources :committees, only: [:new, :create]
      match 'members', to: 'members#merge', via: [:get, :post]
    end
  end

  resources :reports, only: [:index]
  namespace :reports do
    resources :committees,  only: [:index]
    resources :members,     only: [:index]
    resources :resolutions, only: [:index]
    resources :ordinances,  only: [:index]
    resources :minutes,  only: [:index]
    resources :member_profile, only: [:index]
  end
end
