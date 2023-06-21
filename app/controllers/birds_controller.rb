class BirdsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # added rescue_from
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create!(bird_params)
    render json: bird, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  # GET /birds/:id
  def show
    bird = find_bird
    render json: bird
  end

  # PATCH /birds/:id
  def update
    bird = find_bird
    bird.update!(bird_params)
    render json: bird
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  # DELETE /birds/:id
  def destroy
    bird = find_bird
    bird.destroy
    head :no_content
  end

  private

  private

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end
end
