class BirdsController < ApplicationController
rescue_from  ActiveRecord::RecordNotFound, with: :render_response_not_found

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = find_bird
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
      bird = find_bird
      render json: bird
  end

  # PATCH /birds/:id
  def update
      bird = find_bird
      bird.update(bird_params)
      render json: bird
  end

  # PATCH /birds/:id/like
  def increment_likes
      bird = find_bird
      bird.update(likes: bird.likes + 1)
      render json: bird
  end

  # DELETE /birds/:id
  def destroy
      find_bird
      bird.destroy
      head :no_content
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end
  def render_response_not_found
    render json: { error: "Bird not found" }, status: :not_found
  end
  def find_bird
    Bird.find(params[:id])
  end

end
