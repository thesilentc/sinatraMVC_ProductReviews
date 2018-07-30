class ReviewsController < ApplicationController

  # review new action
  get '/reviews/:id/new' do
    if logged_in?
       @product = Product.find_by_id(params[:id])
       erb :'/reviews/create_review'
    else
      redirect to "/login"
    end
  end

  post '/reviews/:id' do
    # binding.pry
    @product = Product.find_by_id(params[:id])
    @user = current_user
    @review = Review.create(:title => params["title"],
                           :review_comment => params["review_comment"],
                           :recommend => params["recommend"],
                           :rating => params["rating"],
                           :user_id => current_user.id,
                           :product_id => @product.id)

     @review.save
     redirect to "/products/#{@product.id}"

 end

  # Review Index Page - list all reviews for this Product
  get '/reviews/:id' do
    if logged_in?
      @product = Product.find_by_id(params[:id])
      @user = current_user
      erb :"/reviews/reviews"
    else
      redirect to "/login"
    end
  end


  # # Review Show page
  # get '/reviews/:id' do
  #     if logged_in?
  #       @product = Product.find_by_id(params[:id])
  #       if Product.exists?(@product)
  #         erb :'/reviews/show_review'
  #       else
  #           redirect to "/login"
  #       end
  #     else
  #       redirect to "/login"
  #     end
  #   end



end
