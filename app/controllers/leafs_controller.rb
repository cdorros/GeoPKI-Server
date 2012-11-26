class LeafsController < ApplicationController
  # GET /leafs
  # GET /leafs.json
  def index
    @leafs = Leaf.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leafs }
    end
  end

  # GET /leafs/1
  # GET /leafs/1.json
  def show
    @leaf = Leaf.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @leaf }
    end
  end

  # GET /leafs/new
  # GET /leafs/new.json
  def new
    @leaf = Leaf.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @leaf }
    end
  end

  # GET /leafs/1/edit
  def edit
    @leaf = Leaf.find(params[:id])
  end

  # POST /leafs
  # POST /leafs.json
  def create
    @leaf = Leaf.new(params[:leaf])
  	
    respond_to do |format|
      if @leaf.save
        format.html { redirect_to @leaf, notice: 'Leaf was successfully created.' }
        format.json { render json: @leaf, status: :created, location: @leaf }
      else
        format.html { render action: "new" }
        format.json { render json: @leaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leafs/1
  # PUT /leafs/1.json
  def update
    @leaf = Leaf.find(params[:id])

    respond_to do |format|
      if @leaf.update_attributes(params[:leaf])
        format.html { redirect_to @leaf, notice: 'Leaf was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @leaf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leafs/1
  # DELETE /leafs/1.json
  def destroy
    @leaf = Leaf.find(params[:id])
    @leaf.destroy

    respond_to do |format|
      format.html { redirect_to leafs_url }
      format.json { head :no_content }
    end
  end
end
