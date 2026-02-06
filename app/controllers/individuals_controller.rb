class IndividualsController < ApplicationController
  before_action :set_individual, only: %i[ show update destroy ]

  # GET /individuals
  def index
    @individuals = Individual.all

    render json: @individuals
  end

  # GET /individuals/1
  def show
    render json: @individual, serializer: IndividualSerializer, depth: 0
  end

  # POST /individuals
  def create
    @individual = Individual.new(model_params)

    if @individual.save
      render json: @individual, status: :created, location: @individual
    else
      render json: @individual.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /individuals/1
  def update
    if @individual.update(model_params)
      render json: @individual
    else
      render json: @individual.errors, status: :unprocessable_entity
    end
  end

  # DELETE /individuals/1
  def destroy
    @individual.destroy!
  end

  def family_tree
    @individual = Individual.find(params[:id])
    depth = params[:depth].present? ? params[:depth].to_i : 3
    
    # Use direct serializer instantiation to avoid model_name errors
    serializer = FamilyTreeSerializer.new(@individual, depth: depth)
    render json: serializer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_individual
      @individual = Individual.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def model_params
      params.require(:individual).permit(:name)
    end
end
