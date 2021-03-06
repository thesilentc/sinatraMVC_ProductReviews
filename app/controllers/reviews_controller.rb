require 'rack-flash'
class ReviewsController < ApplicationController

  use Rack::Flash

  # review new action
  get '/reviews/:id/new' do
    if logged_in?
       @product = Product.find_by_id(params[:id])
       erb :'/reviews/create_review'
    else
      redirect to "/login"
    end
  end

  # create review
  post '/reviews/:id' do
    @product = Product.find_by_id(params[:id])
    @user = current_user
    @review = Review.create(:title => params["title"],
                           :review_comment => params["review_comment"],
                           :recommend => params["recommend"],
                           :rating => params["rating"],
                           :user_id => current_user.id,
                           :product_id => @product.id)

     if @review.save
       flash[:message] = "Successfully created Review !!"
       redirect to "/products/#{@product.id}"
     else
       flash[:message] = "Un-Successfully created Review."
       redirect to "/reviews/#{@product.id}/new"
     end

 end

 # reviews show page for user
 get '/reviews/:id/show' do
   if logged_in?
     @show_user = User.find_by_id(params[:id])
     @reviews = Review.where(:user_id => params[:id], :rating => [4,5])
     erb :"/reviews/show_review"
   else
     redirect to "/login"
   end
 end

  # Review Index Page - list all reviews for this Product
  get '/reviews/:product_id' do
    if logged_in?
      @product = Product.find_by_id(params[:product_id])
      @reviews = Review.where(:product_id => @product.id)
      @user = current_user
      redirect to "/products/#{@product.id}"
    else
      redirect to "/login"
    end
  end



  # update review
  post '/reviews/:product_id/edit/:review_id' do
  # update logic
    # raise params.inspect
    @product = Product.find_by_id(params[:product_id])
    @review = Review.find_by_id(params[:review_id])
    @user = current_user
    if params[:title] == "" || params[:comment] == ""
           redirect to "/reviews/#{@product.id}/edit/#{@review.id}"
   else
    #  binding.pry
     @review.update(:title => params["title"], :review_comment => params["review_comment"], :recommend => false, :rating => params["rating"], :user_id => @user.id, :product_id => @product.id)
     if @review.save
       flash[:message] = "Successfully updated Review !!"
       redirect to "/products/#{@product.id}"
     else
       flash[:message] = "Un-Successfully updated Review."
       redirect to "/reviews/#{@product.id}/edit/#{@review.id}"
     end
    end
  end

  # edit link for review
  get '/reviews/:product_id/edit/:review_id' do
    if logged_in?
      @product = Product.find_by_id(params[:product_id])
      @review = Review.find_by_id(params[:review_id])
      erb :'/reviews/edit_review'
   else
     redirect to "/login"
   end
  end

  # delete link for review
  delete '/reviews/:id/delete' do
    @review = Review.find_by_id(params[:id])
    @review.delete
    if @review.save
      flash[:message] = "Successfully deleted Review !!"
      redirect to "/reviews/#{@review.product_id}"
    else
      flash[:message] = "Un-Successfully deleted Review !!"
      redirect to "/reviews/#{@review.product_id}"
    end
  end

end
