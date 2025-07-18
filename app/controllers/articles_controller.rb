class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :same_user, only: [:edit, :update, :destroy]

    def show
    end

    def edit
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user 
        if @article.save
            flash[:notice] = "Article was successfully created."
            redirect_to @article
            # redirect_to articles_path(@article) #this will take to the index page/ where articles are listed

        else
            render 'new'  
            # render 'articles/new' #this will take to the new page where we can create a new article
        end
    end

    def update
        if @article.update(article_params)
            flash[:success] = "Article was successfully updated."
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        flash[:error] = "Article was successfully deleted."
        redirect_to articles_path
    end
    # def destroy
    #     @article = Article.find(params[:id])
    #     @article.destroy
    #     # flash[:notice] = "Article was successfully deleted."
    #     redirect_to articles_path
    # end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def same_user
        if @article.user != current_user && !current_user.admin
            flash[:danger] = "You can only edit or delete your own articles."
            redirect_to @article
        end
    end
    
end