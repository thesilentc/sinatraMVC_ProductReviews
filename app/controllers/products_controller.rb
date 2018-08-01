require 'rack-flash'

class ProductsController < ApplicationController
  use Rack::Flash

  # product new action
  get '/products/new' do
    if logged_in?
      erb :'/products/create_product'
    else
      redirect to "/login"
    end
  end

  # Product Index Page - list all products
  get '/products' do
    if logged_in?
      @user = current_user
      erb :"/products/products"
    else
      redirect to "/login"
    end
  end

  # Product Show page
  get '/products/:id' do
      if logged_in?
        @product = Product.find_by_id(params[:id])
        @reviews = Review.where(:product_id => @product.id)
        @user = current_user

        if Product.exists?(@product)
          erb :'/products/show_product'
        else
            redirect to "/login"
        end
      else
        redirect to "/login"
      end
    end

    # create a new product
    post '/products' do
     if params[:name] == "" || params[:description] == ""
       redirect "/products/new"
     else
       @product = Product.create(:name => params["name"], :description => params["description"], :user_id => current_user.id)
       if @product.save
         flash[:message] = "Successfully created Product !!"
         redirect to "/products/#{@product.id}"
       else
         flash[:message] = "This Product name already exits !"
         redirect "/products/new"
       end
     end
   end


   # update product
   post '/products/:id' do
   # update logic
      # raise params.inspect
     @product = Product.find_by_id(params[:id])

     if params[:name] == "" || params[:description] == ""
            redirect to "/products/#{@product.id}/edit"
    else
            # binding.pry
            @product.update(:name => params[:name], :description => params[:description], :user_id => current_user.id)
            if @product.save
              flash[:message] = "Successfully updated Product !!"
              redirect to "/products/#{@product.id}"
            else
              flash[:message] = "This Product name already exists !"
              redirect to "/products/#{@product.id}/edit"
            end
     end
   end

   # edit link for product
   get '/products/:id/edit' do
     if logged_in?
       @product = Product.find_by_id(params[:id])
       erb :'/products/edit_product'
    else
      redirect to "/login"
    end
   end

   # delete link for product
   delete '/products/:id/delete' do
     @product = Product.find_by_id(params[:id])

     flash[:alert] = "Are you sure you want to delete this product"

     @product.delete
     if @product.save
          @reviews = Review.where(:product_id => @product.id)
          @reviews.delete_all

          flash[:message] = "Successfully deleted this Product !! All reviews for this Product were also deleted !!"
          redirect to "/products"
      else
          flash[:message] = "This Product was not deleted !!"
          redirect to "/products/#{@product.id}"
      end
   end

   helpers do
     def current_product
     end
   end



end
