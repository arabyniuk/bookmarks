class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  skip_before_filter :set_current_link, only: [:new, :edit, :destroy]
  before_filter :authenticate_user!, :set_current_link

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
    @lists = List.all
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
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:url, :title, :list_id)
    end

    def set_current_link
      path = request.original_fullpath.gsub(/^\//, "")
      subdomain = request.subdomain
      if !subdomain.empty? || !path.empty?
        unless subdomain.empty?
          list = List.where(name: subdomain).first
          if list.nil?
             list = List.new({name: subdomain})
             list.save
          end
        end
        unless path.empty?
          begin
            title = Mechanize.new.get(path).title
          rescue Exception => e
           flash[:notice] = e.message
          end
          path = path.gsub(/^(h.*?\/+)/, "")
          link = Link.new({url: path, title: title})
          link.list_id = list.id unless subdomain.empty?
          link.save
        end
        redirect_to root_url( subdomain: false )
      end
    end

end
