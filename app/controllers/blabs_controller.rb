class BlabsController < ApplicationController
  # GET /blabs
  # GET /blabs.json
  def index
    @blabs = Blab.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blabs }
    end
  end

  # GET /blabs/1
  # GET /blabs/1.json
  def show
    @blab = Blab.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blab }
    end
  end

  # GET /blabs/new
  # GET /blabs/new.json
  def new
    @blab = Blab.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blab }
    end
  end

  # GET /blabs/1/edit
  def edit
    @blab = Blab.find(params[:id])
  end

  # POST /blabs
  # POST /blabs.json
  def create
    @blab = Blab.new(params[:blab])

    respond_to do |format|
      if @blab.save
      	current_user.blabs << @blab
        format.html { redirect_to blabs_path, notice: 'good job blabber mouth.' }
        format.json { render json: @blab, status: :created, location: @blab }
      else
        format.html { render action: "new" }
        format.json { render json: @blab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /blabs/1
  # PUT /blabs/1.json
  def update
    @blab = Blab.find(params[:id])

    respond_to do |format|
      if @blab.update_attributes(params[:blab])
        format.html { redirect_to blabs_path, notice: 'good job blabber mouth.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blabs/1
  # DELETE /blabs/1.json
  def destroy
    @blab = Blab.find(params[:id])
    @blab.destroy

    respond_to do |format|
      format.html { redirect_to blabs_url }
      format.json { head :no_content }
    end
  end
end
