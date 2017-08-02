Rails.application.routes.draw do
  resources :recipes, only: [:index]

  get '/results', to: 'recipes#search_results'
  get '/details', to: 'recipes#recipe_details'

end
