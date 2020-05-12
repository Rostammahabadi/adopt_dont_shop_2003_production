class ReviewsController < ApplicationController
    def new

    end
    
    def create
        review = Review.create(review_params)
        redirect_to "/shelters/:shelter_id"
    end

    private

    def review_params
        params.permit(:title, :rating, :content, :image)
    end
end