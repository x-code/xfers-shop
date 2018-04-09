Rails.application.routes.draw do
  root 'accounts#user_details'
  get '/user_details' => "accounts#user_details"
  post '/charge' => "accounts#charge"
  get '/return' => "accounts#return"
  get '/cancel' => "accounts#cancel"
  get '/payment_notification' => "accounts#payment_notification"
end
