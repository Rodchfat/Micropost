class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
  @articles = Article.paginate(page: params[:page], per_page: 2)
  end
  def next_pre
    @article = Article.next
  end
  
  def show
    @article = Article.find(params[:id])
  end

  def create
    debugger
  @article = Article.new(article_params)
  @article.user = User.first
  if @article.save
  flash[:success] = "Article was successfully created"
  redirect_to article_path(@article)
  else
  render 'new'
  end
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def destroy
    @article = Article.find(params[:id])
    if @article.delete 
      flash[:danger] = "You article was successfuly deleted"
    redirect_to articles_path
    else
    render 'edit'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article is successfully Updated"
    else
      render 'edit'
    end
  end
  
  private
  def article_params
  params.require(:article).permit(:title, :description)
  
  end
  
end
