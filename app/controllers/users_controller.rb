# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  respond_to :html, :js

  def show
    @places = @user.places.publicly_shared
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def deactivate
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

  def set_user
    @user = if params[:username]
              User.find_by(username: params[:username])
            else
              User.find_by(id: params[:id])
            end
    render_404 and return unless @user
  end
end
