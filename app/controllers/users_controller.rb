require 'rack-flash'
class UsersController < ApplicationController
    use Rack::Flash

    get '/signup' do
      erb :'/users/create_user'
    end

    post '/signup' do
      # raise params.inspect
      if params[:username] == "" || params[:email] == "" || params[:password] == ""
          flash[:message] = "Username, Email OR Password cannot be blank!"
          redirect to '/signup'
      else
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
        if @user.save
          flash[:message] = "Successfully created User !!"
          session[:user_id] = @user.id
          redirect to :'/products'
        else
          flash[:message] = "Un-Successfully created User. Incorrect Email OR Password."
          redirect to '/signup'
        end
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
        if User.exists?@user
          if @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/products"
          else
            flash[:message] = "Incorrect Email OR Password"
            redirect '/login'
          end
        else
          flash[:message] = "This account does not exists. Please create a new account !"
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
        if User.exists?(@user) && @user.logged_in?
          erb :'/users/show'
        else
          redirect "/login"
        end
    end

end
