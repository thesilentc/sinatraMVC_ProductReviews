class ProductsController < ApplicationController

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
        erb :'/products/show_product'
      else
        redirect to "/login"
      end
    end

    post '/products' do
     if params[:name] == "" || params[:description] == ""
       redirect "/products/new"
     else
       @product = Product.create(:name => params["name"], :description => params["description"])
       @product.user_id = current_user.id
       @product.save
       redirect to "/products/#{@product.id}"
     end
   end




end
