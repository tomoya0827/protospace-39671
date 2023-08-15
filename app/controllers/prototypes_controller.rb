class PrototypesController < ApplicationController

  before_action :move_to_index, except: [:index, :show]  #リダイレクト処理追加している
  before_action :set_prototype, only: [:edit, :show] #追加
  before_action :check_author, only: [:edit] #追加

  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)
    
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
    
  end

  def show
    @prototype = Prototype.find(params[:id]) 
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params)
      #redirect_to root_path
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def set_prototype
    @prototype = Prototype.find_by(id: params[:id])
    unless @prototype
      redirect_to root_path
    end
  end

  def check_author
    unless current_user == @prototype.user
      redirect_to root_path
    end
  end


end
