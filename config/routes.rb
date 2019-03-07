Rails.application.routes.draw do
  resources :people
  resources :comments
  root to: redirect('/comments')
end
