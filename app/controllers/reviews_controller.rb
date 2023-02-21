class ReviewsController < ApplicationController
  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @recipe = Recipe.find(params[:review][:recipe_id])
    respond_to do |format|
      if @review.save
        format.html { redirect_to recipe_path(@recipe), notice: "Review was successfully added." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:recipe_id, :rating)
    end
end
