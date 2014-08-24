Rails.application.routes.draw do
  
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

  resources :posts do
    collection do
      get 'fresh'
      get 'rising'
    end
  end

  resources :posts do
    resources :votes
    resources :comments
  end

  resources :comments do
    resources :replies
  end

  # get 'posts/fresh' => 'fresh#index', 
  #     :as => :fresh_posts_index, 
  #     :action => :index_fresh
  # get 'posts/controversial' => 'controversial#index', 
  #     :as => :controversial_posts_index, 
  #     :action => :index_controversial
  # get 'posts/rising' => 'rising#index', 
  #     :as => :rising_posts_index, 
  #     :action => :index_rising

end
