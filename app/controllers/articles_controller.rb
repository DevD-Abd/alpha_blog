class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
    end
    def index
        @articles = Article.all
    end
    def new
        @article = Article.new
    end
    def create
        @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
            flash[:notice] = "Article was successfully created."
            redirect_to @article
            # redirect_to articles_path(@article) #this will take to the index page/ where articles are listed

        else
            render 'new'  
            # render 'articles/new' #this will take to the new page where we can create a new article
        end
    end
end