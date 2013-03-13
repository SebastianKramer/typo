class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  def index 
    redirect_to :action => 'new' 
  end
  
  def new 
    @category = Category.new
    @categories = Category.all
    respond_to do |format|
      format.html { @category }#new_or_edit }
      format.js { 
        @category = Category.new
      }
    end
  end

  def edit_create
    #debugger
    @categories = Category.all

    @category = Category.new 
    @category.attributes = params[:category] #edit 
       
    
    if request.post?
      respond_to do |format|
        format.html do 
          if @category.save!
            flash[:notice] = _('Category was successfully saved.')
          else
            flash[:error] = _('Category could not be saved.')
          end
          redirect_to :action => 'new'
        end
        format.js do 
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
      #return
    else
    render 'new'      
    end
  end

  def edit 
    #new_or_edit 
    @categories = Category.all
    if params[:id]
      @category = Category.find(params[:id]) # edit
    end
    if params[:category] 
      @category.attributes = params[:category] #edit 
    end 
    render 'edit' 
  end

  def edit_update
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id]) # edit
    end
    if params[:category] 
      @category.attributes = params[:category] #edit 
    end   
    

    if request.post?
      respond_to do |format|
        format.html do 
          if @category 
            @category.save!
            flash[:notice] = _('Category was successfully saved.')
          else
            flash[:error] = _('Category could not be saved.')
          end
          redirect_to :action => 'new'
        end
        format.js do 
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
    end
  end

  def new_or_edit
    #debugger
    @categories = Category.all

    if params[:id]
      @category = Category.find(params[:id]) # edit
    end
    if params[:category] 
      @category.attributes = params[:category] #edit 
    end   
    

    if request.post?
      respond_to do |format|
        format.html do 
          if @category 
            @category.save!
            flash[:notice] = _('Category was successfully saved.')
          else
            flash[:error] = _('Category could not be saved.')
          end
          redirect_to :action => 'new'
        end
        format.js do 
          @category.save
          @article = Article.new
          @article.categories << @category
          return render(:partial => 'admin/content/categories')
        end
      end
      #return
    else
    render 'new'      
    end
  end

  private




  public
  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end

  





end
