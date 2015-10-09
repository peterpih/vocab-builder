Rails.application.routes.draw do



  get 'say/hello'
  get 'say/goodbye'
  get :next_word, to: "vocab_words#next", as: :next_word
  get :unique_lesson, to: "vocab_words#unique_lessons", as: :unique_lesson
  get 'vocab_words/unique_lessons'
  #get 'vocab_words/choose_lesson'
  get :choose_lesson, to: "vocab_words#choose_lesson", as: :choose_lesson
  get :quiz_init, to: "vocab_words#quiz_init", as: :quiz_init
  get :quiz_next, to: "vocab_words#quiz_next", as: :quiz_next
  get :quiz_finish, to: "vocab_words#quiz_finish", as: :quiz_finish
  get :quiz_correct, to: "vocab_words#quiz_correct", as: :quiz_correct
  #get 'vocab_words/index'

  resources :vocab_words
  resources :result_lists
  resources :stop_watches
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  #root 'say#hello'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
