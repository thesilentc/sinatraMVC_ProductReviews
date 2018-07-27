class ProductsController < ApplicationController

  get '/products/new' do
    if logged_in?
      erb :'/products/create_product'
    else
      redirect to "/login"
    end
  end

  get '/products' do
    if logged_in?
      @user = current_user
      erb :"/products/products"
    else
      redirect to "/login"
    end

  end

end
