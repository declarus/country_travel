class CountriesController < ApplicationController
  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countries }
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    @country = Country.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/new
  # GET /countries/new.json
  def new
    @country = Country.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @country }
    end
  end

  # GET /countries/1/edit
  def edit
    @country = Country.find(params[:id])
  end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(params[:country])

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render json: @country, status: :created, location: @country }
      else
        format.html { render action: "new" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def editmultiple
    @countries = Country.all
    @edit_countries = Country.find(params[:country_ids])
    @edit_countries.each do |country|
      if country.visited == true
        country.visited = false
      else
        country.visited = true
      end
      country.save
    end
  end

  def update_multiple
    @countries = Country.find(params[:countries_ids])
    @countries.each do |country|
      country.update_attributes!(params[:country].reject { |k,v| v.blank? })
    end
    flash[:notice] = "Updated countries!"
    redirect_to products_path
  end


  # PUT /countries/1
  # PUT /countries/1.json
  def update
    @countries = Country.all
    @country = Country.find(params[:id])
    @country.name = params[:name]
    @country.save
    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /countries/1
  # DELETE /countries/1.json
  def destroy
    @country = Country.find(params[:id])
    @country.destroy

    respond_to do |format|
      format.html { redirect_to countries_url }
      format.json { head :no_content }
    end
  end
end
