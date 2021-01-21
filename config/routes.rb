Rails.application.routes.draw do
  root 'patients#index'
  resources :patients
  get 'patients/:id/decrypt_hl7', to: 'patients#decrypt_hl7'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
