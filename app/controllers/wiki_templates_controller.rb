class WikiTemplatesController < ApplicationController
  unloadable
  menu_item :settings
  model_object WikiTemplate

  before_action :find_project_by_project_id, :only => [:new, :update]
  before_action :find_model_object, :except => [:new, :preview]
  before_action :find_project_from_association, :except => [:new, :preview]
  before_action :authorize, :except => [:preview, :load]

  def new
    @wiki_template = WikiTemplate.new(:project => @project, :author => User.current)
    if request.post? or request.patch?
      @wiki_template.attributes = wiki_template_params
      if @wiki_template.save
        flash[:notice] = l(:notice_successful_create)
        redirect_to settings_project_path(@project, :tab => 'wiki_templates')
      else
        render :action => 'new'
      end
    end
  end

  def edit
  end

  def update
    @wiki_template.attributes = wiki_template_params
    if (request.post?  or request.patch?) and @wiki_template.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to settings_project_path(@project, :tab => 'wiki_templates')
    else
      render :action => 'edit'
    end
  end

  def destroy
    if request.delete? and @wiki_template.destroy
      flash[:notice] = l(:notice_successful_delete)
    end
        redirect_to settings_project_path(@project, :tab => 'wiki_templates')
  end

  def preview
    template = WikiTemplate.find_by_id(params[:id])
    if template
      @previewed = template.text
    end
    @text = params[:wiki_template] ? params[:wiki_template][:text] : nil
    render :partial => 'common/preview'
  end

  def load
    render plain: @wiki_template.text
  end

  private

  def wiki_template_params
    params.require(:wiki_template).permit(:name, :text, :is_public)
  end
  
  def find_user
    @user = User.current
  end

end
