class LinksController < ApplicationController
  before_action :set_link, except: [:index, :new]
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /links
  def index
    @links = Link.all
  end

  # GET /links/1
  def show
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  def create
    @link = current_user.links.build(link_params)

    if @link.save
      flash[:success] = 'Link was successfully created.'
      redirect_to @link
    else
      render :new
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      flash[:success] = 'Link was successfully updated.'
      redirect_to @link
    else
      render :edit
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
    flash[:success] = 'Link was successfully destroyed.'
    redirect_to links_url
  end

  def upvote
    @link.upvote_by current_user
    flash[:success] = 'Link was successfully upvoted.'
    redirect_back fallback_location: root_url
  end

  def downvote
    @link.downvote_from current_user
    flash[:success] = 'Link was successfully downvoted.'
    redirect_back fallback_location: root_url
  end

  private

    def set_link
      @link = Link.find(params[:id])
    end

    def authorized_user
      @link = current_user.links.find_by(id: params[:id])

      if @link.nil?
        flash[:error] = "Sorry, you can't edit someone else's links."
        redirect_to links_path
      end
    end

    def link_params
      params.require(:link).permit(:title, :url)
    end
end
