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

  # POST /relationships/1/create_with_new_person
  def create_with_new_person
   @individual = Individual.find_by(id: params[:id])
    # Ensure the individual exists before trying to create a relationship for them
    unless @individual
      render json: { error: "Individual not found" }, status: :not_found
      return
    end

    #  A transaction will ensure that both of these operations succeed or fail together.
    #  i.e. don't create an Individual if the Relationship can't be created and vice versa
    ActiveRecord::Base.transaction do
      # Operation 1: Create individual
      @new_individual = Individual.create!(name: params[:name])
      
      # Operation 2: Create relationship
      @relationship = Relationship.create!(
        individual_id: params[:id],
        relative: @new_individual,
        relationship_type_id: params[:relationship_type_id]
      )

      render json: @relationship, status: :created
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
