class ArticlesController < ApplicationController
  #A frequent practice is to place the standard CRUD actions in each controller in the following order: index, show, new, edit, create, update and destroy

  # Need to authenticate for all actions but index and show    
  http_basic_authenticate_with name: "rails", password: "rails", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    # to find the article we're interested in, passing in params[:id] to get the :id parameter from the request
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # Map params[:article] to the respective database columns
    @article = Article.new(article_params)

    # @article.save is responsible for saving the model in the database
    if @article.save
      redirect_to @article
    else #When @article.save validates is not met
      # The new action is now creating a new instance variable called @article   
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    # Allow and require the title and text parameters for valid use of create
    params.require(:article).permit(:title, :text)
  end
end
