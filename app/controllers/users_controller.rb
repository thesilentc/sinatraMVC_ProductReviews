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

    # get 'login' do
    # end
    #
    # post 'login' do
    # end
    #
    # get 'logout' do
    # end

    # get 'users/:slug' do
    # end

end
