class UsersController < ApplicationController

    get 'signup' do
      erb :'/users/create_user'
    end

    post 'signup' do
    end

    get 'login' do
    end

    post 'login' do
    end

    get 'logout' do
    end

    get 'users/:slug' do
    end

end
