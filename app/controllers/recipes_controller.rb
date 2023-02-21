require 'json'
class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show edit update destroy ]

  # GET /recipes or /recipes.json
  def index
    if params[:session].nil?
      @sql_query = "
      SELECT recipes.* FROM recipes
      "
    else
      if params[:session][:name].blank? and params[:session][:orient].blank? and params[:session][:shape].blank? and params[:session][:category].blank? and params[:session][:for_review].blank?
        @sql_query = "
        SELECT recipes.* FROM recipes
        "
      else
        @sql_query = "
        SELECT recipes.* FROM recipes
        where 1 = 1
        #{'AND recipes.name ILIKE \'%' + params[:session][:name] + '%\'' if !params[:session][:name].blank? }
        #{' AND (recipes.orient ILIKE \'%' + params[:session][:orient] + '%\' )' if !params[:session][:orient].blank? }
        #{'AND (recipes.shape ILIKE \'%' + params[:session][:shape] + '%\' )' if !params[:session][:shape].blank? }
        #{' AND (\'' + params[:session][:category] + '\' = ANY(recipes.categories) )' if !params[:session][:category].blank? }
        #{' AND (recipes.for_review = true)' if !params[:session][:for_review].blank? and params[:session][:for_review] == "1" }
        "
      end
    end
    @recipes_filtered = ActiveRecord::Base.connection.exec_query(@sql_query)
    selected_recipes_ids = @recipes_filtered.rows.map {|recipe| recipe.first}
    @recipes = Recipe.find(selected_recipes_ids)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @review = Review.new
    @recipe_materials = JSON.parse(@recipe.materials)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    @materials = @recipe.materials unless @recipe.materials.nil?
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        materials_per_portion = JSON.parse(@recipe.materials)
        materials_per_portion.each do |material|
          material["Ποσότητα"] = "#{(material["Ποσότητα"]/@recipe.portions.to_f)}"
        end
        materials_per_portion_json = materials_per_portion.to_json
        @recipe.update_column(:materials_per_portion, materials_per_portion_json)
        format.html { redirect_to recipe_url(@recipe), notice: "Η συνταγή καταχωρήθηκε επιτυχώς!" }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        materials_per_portion = JSON.parse(@recipe.materials)
        materials_per_portion.each do |material|
          material["Ποσότητα"] = "#{(material["Ποσότητα"]/@recipe.portions.to_f)}"
        end
        materials_per_portion_json = materials_per_portion.to_json
        @recipe.update_column(:materials_per_portion, materials_per_portion_json)
        format.html { redirect_to recipe_url(@recipe), notice: "Η συνταγή ανανεώθηκε επιτυχώς!" }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Η συνταγή διαγράφηκε επιτυχώς!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      if params[:session].nil?
        params.require(:recipe).permit(:name, :orient, :difficulty, :excecution_time, :instructions, :portions, :photo, :for_review, :from_admin, :shape, {categories: []}, :materials)
      end    
    end
end
