class ProductsController < ApplicationController

  get '/products' do
    if logged_in?
      @user = current_user
      puts @user
      erb :"/products/products"
    else
      # redirect to "/login"
    end

  end

end
