class UsersController < ApplicationController

    get '/signup' do
      erb :'/users/create_user'
    end

    post '/signup' do
      # raise params.inspect
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
      else
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to :'/products'
      end

    end

    get '/login' do
      if logged_in?
        redirect to :"/products"
      else
        erb :'/users/login'
      end
    end

    post '/login' do
      @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/products"
        else
            redirect '/signup'
        end
    end

    get '/logout' do
      if logged_in?
        session.destroy
        redirect "/login"
      else
          redirect "/"
      end
    end

    get '/users/:slug' do
      @user = User.find_by_slug(:slug)
        if @user.logged_in?
          erb :'/users/show'
        end
    end

end
