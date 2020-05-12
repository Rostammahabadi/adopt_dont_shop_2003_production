class ReviewsController < ApplicationController
    def new
        @shelter_id = params[:shelter_id]
    end
    
    def create
        shelter = Shelter.find(params[:shelter_id])
        review = shelter.reviews.new(*review_params)
        if review.save
            redirect_to "/shelters/#{shelter.id}"
        else
            flash[:notice] = "Review not posted: You must fill in the Title, Rating, and Content in order to post a review."
            redirect_to "/shelters/#{shelter.id}/reviews/new"
        end
    end

    private

    def review_params
        params.permit(:title, :rating, :content, :picture)
    end
end