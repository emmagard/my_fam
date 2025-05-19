class FamilyTreeSerializer
  attr_reader :root_individual

  def initialize(root_individual, options = {})
    @root_individual = root_individual
    @options = options
    @max_depth = options[:depth] || 3
  end
  
  def as_json(*)
    # Reset tracking for new serialization
    IndividualSerializer.reset_tracking
    IndividualSerializer.recursion_depth = @max_depth
    
    # Start serialization from the root individual
    # Explicitly use the IndividualSerializer to avoid model_name inference
    serializer = IndividualSerializer.new(@root_individual)
    serializer.as_json
  end
  
  # Allow serializer to be used directly with render json:
  def to_json(*)
    as_json.to_json
  end
  
  # Make it compatible with Rails' render method
  def read(*)
    self
  end
end
