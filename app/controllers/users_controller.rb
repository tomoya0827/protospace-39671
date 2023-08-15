class UsersController < ApplicationController
  def show
    #@prototypes = current_user.prototypes
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
  end
end
