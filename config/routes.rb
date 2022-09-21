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
    resources :settings, only: [:index],          module: :users
    resources :passwords, only: [:edit, :update], module: :users
  end

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
  end

  resources :resolutions do
    resources :documents, only: [:create, :destroy], module: :resolutions
    resources :sponsors, module: :resolutions
    resources :authors, module: :resolutions
    resources :stages, module: :resolutions
  end

  resources :ordinances do
    resources :documents, only: [:create, :destroy], module: :ordinances
    resources :sponsors, module: :ordinances
    resources :authors, module: :ordinances
    resources :stages, module: :ordinances
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
    resources :term_settings
    resources :political_parties
    resources :terms
    resources :positions
    namespace :importers do
      resources :members, only: [:create]
      resources :committees, only: [:create]
      resources :ordinances, only: [:create]
      resources :ordinance_authors, only: [:create]
      resources :ordinance_sponsors, only: [:create]
      resources :ordinance_documents, only: [:create]
      resources :resolutions, only: [:create]
      resources :resolution_authors, only: [:create]
      resources :resolution_documents, only: [:create]
      resources :memberships, only: [:create]
      resources :member_terms, only: [:create]
    end
    namespace :mergers do
      resources :committees, only: [:new, :create]
      match 'members', to: 'members#merge', via: [:get, :post]
    end
  end
end
