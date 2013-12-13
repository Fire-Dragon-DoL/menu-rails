Rails.application.routes.draw do
  root to: 'pages#home'

  get 'about'  => 'pages#about'
  get 'dummy1' => 'pages#dummy1'
end
