class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  def index 
    redirect_to :action => 'new' 
  end

  def new
    cat_controller
  end

  def edit
    cat_controller
  end

  def cat_controller
    #debugger
    #categories/new - new_after
    #{"action"=>"new", "id"=>nil, "controller"=>"admin/categories"}
    
    if params[:action] == 'new'
      if request.post?
        create_after
      else
        new_after
      end
    end


    # if params[:id] == nil
    #   new_after
    # end
    #categories/edit/1 - edit_after
    #{"action"=>"edit", "id"=>"1", "controller"=>"admin/categories"}
    if params[:action] == 'edit'
      if request.post?
        if params[:id] == nil
          create_after
        else
          update_after
        end
      else
        edit_after
      end
    end




    #edit
  end
  
  def new_after 
    @category = Category.new
    @categories = Category.all
    respond_to do |format|
      format.html do 
        @category
        render 'new' # dont know if this renders correctly
      end#new_or_edit }
      format.js { 
        @category = Category.new
      }
    end
  end

  def create_after
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

  def edit_after 
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

  def update_after
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
