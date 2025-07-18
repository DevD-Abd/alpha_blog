class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :same_user, only: [:edit, :update, :destroy]
    
    def new
        @user = User.new
    end

    def edit
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    end

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account was updated successfully"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the Alpha Blog #{@user.username}!"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def destroy
        if @user.destroy
            session[:user_id] = nil if @user == current_user
            flash[:success] = "User was successfully deleted."
            redirect_to articles_path
        else
            flash[:error] = "User could not be deleted."
            redirect_to @user
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        @user = User.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    #     flash[:error] = "User not found"
    #     redirect_to root_path
    end
    
    def same_user
        if @user != current_user
            flash[:danger] = "You can only edit your own profile."
            redirect_to @user
        end
    end
end