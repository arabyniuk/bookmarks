class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!
  #skip_before_action :authenticate_user!, only: [:set_current_link]

  include PathFormatter

  # GET /links
  # GET /links.json
  def index
    if user_signed_in?
      @links = Link.where(user_id: current_user.id).order('created_at DESC')
      @categories = Category.where(user_id: current_user.id)
    else
      flash[:notice] = "You are not authorized for this action."
      #redirect_to root_url(subdomain: false)
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to root_url, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def obtain_folder_path
    #WeeklyNotifier.received(current_user).deliver
    return nil unless subdomain || folder_path
    category = category_publish || {}

    link_publish(category) unless folder_path.blank?
    redirect_to root_url(subdomain: false)
  end

  private

  def link_publish(category)
    begin
      link = Link.new(url: folder_path_without_prefix,
                       title: folder_path_title,
                       user_id: current_user.id,
                       category_id: category.fetch(:id, nil) )

      link.save
    rescue Exception => e
      flash[:notice] = e.message
    end
  end

  def category_publish
    return nil if fit_subdomain?
    category = Category.new(name: subdomain, user_id: current_user.id)
    category.save
    category
  end

  def fit_subdomain?
    fit_folder_path_subdomain? || existing_category?(subdomain)
  end

  def existing_category?(subdomain)
    Category.subdomain(subdomain, current_user.id).any?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white category through.
  def link_params
    params.require(:link).permit(:url, :title, :category_id)
  end
end
