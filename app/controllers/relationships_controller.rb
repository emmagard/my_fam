class RelationshipsController < ApplicationController
  before_action :set_relationship, only: %i[ show update destroy ]

  # GET /relationships
  def index
    @relationships = Relationship.all

    render json: @relationships
  end

  # GET /relationships/1
  def show
    render json: @relationship
  end

  # POST /relationships
  def create
    @relationship = Relationship.new(model_params)

    if @relationship.save
      render json: @relationship, status: :created, location: @relationship
    else
      render json: @relationship.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /relationships/1
  def update
    if @relationship.update(model_params)
      render json: @relationship
    else
      render json: @relationship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /relationships/1
  def destroy
    @relationship.destroy!
  end

  def create_with_new_person
   @individual = Individual.find_by(id: params[:id])
  
    unless @individual
      render json: { error: "Individual not found" }, status: :not_found
      return
    end

    ActiveRecord::Base.transaction do
      @new_individual = Individual.create!(name: params[:name])
      @new_relationship = Relationship.create!(
        individual_id: params[:id],
        relative: @new_individual,
        relationship_type_id: params[:relationship_type_id]
      )
      
      # Correct way to use ActiveModel::Serializer
      render json: @new_relationship, status: :created
    end
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      @relationship = Relationship.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def model_params
      params.require(:relationship).permit(:individual_id, :relative_id, :relationship_type_id)
    end
end
