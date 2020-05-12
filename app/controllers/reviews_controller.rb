class ReviewsController < ApplicationController

def new
      @shelter_id = params[:shelter_id]
  end

  def create
      shelter = Shelter.find(params[:shelter_id])
      shelter.reviews.create(review_params)
      redirect_to "/shelters/#{shelter.id}"
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    if review.update(review_params)
      redirect_to "/shelters/#{review.shelter_id}"
    else
      flash[:notice] = "Need to enter title, rating, and review in order to update."
      redirect_to "/shelters/#{review.shelter_id}/reviews/#{review.id}/edit"
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :picture)
  end
end
