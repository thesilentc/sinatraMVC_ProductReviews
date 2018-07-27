class ReviewsController < ApplicationController
  # review new action
  get '/reviews/new' do
    if logged_in?
      erb :'/reviews/create_review'
    else
      redirect to "/login"
    end
  end

end
