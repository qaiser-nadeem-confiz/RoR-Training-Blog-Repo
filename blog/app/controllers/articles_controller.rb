class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "confiz", password: "confiz123", except: [:index, :show]

	def new
    @article = Article.new
	end
 
  	def create
      @article = Article.new(params[:article])
      if @article.save
        redirect_to @article

      else
        render 'new'
      end
	end

	def index

  	@articles = Article.all
	end
 

def show
  @article = Article.find(params[:id])
end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(params[:article])
      redirect_to @article
    else
      render 'edit'
    end
  end

  def showTitle
    @articles=Article.where("title LIKE '%" +params[:title]+"%'");

    render 'index'
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def saveFile
    uploaded_io = params[:file]
    dir = File.dirname("#{Rails.root}/public/uploads/temp")
    FileUtils.mkdir_p(dir)
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      flash[:msg]="File Uploaded Succesffuly"
      @articles = Article.all
      render 'index'
    end
  end
  def upload


  end
  def search
    @text=params[:text]
    @title=params[:title]
    if(params[:text].blank? and params[:title].blank?)

    else
      @articles=Article.where("title LIKE '%" +@title.to_s.strip+"%' and text LIKE '%"+@text.to_s.strip+"%'" );



      render 'index'
    end

  end


end
