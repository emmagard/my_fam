class IndividualSerializer < ActiveModel::Serializer
  attributes :id,
             :name

  class_attribute :visited_individuals

  class_attribute :recursion_depth
  self.recursion_depth = 2

  def self.current_depth
    Thread.current[:individual_serializer_depth] ||= 0
  end

  def self.current_depth=(value)
    Thread.current[:individual_serializer_depth] = value
  end

  def self.visited_individuals
    Thread.current[:visited_individuals] ||= Set.new
  end

  def self.visited_individuals=(value)
    Thread.current[:visited_individuals] = value
  end

  def self.reset_tracking
    self.current_depth = 0
    self.visited_individuals = Set.new
  end

  attribute :relationships do
    if already_visited? || max_depth_reached?
      # Return minimal information to avoid circular references
      { reference: true, count: object.all_relationships.count }
    else
      # Mark as visited
      self.class.visited_individuals << object.id

      # Increase depth for child serialization
      current_depth = self.class.current_depth
      self.class.current_depth = current_depth + 1

      # Serialize relationships
      result = {
        parents: serialize_related_individuals(object.parents),
        children: serialize_related_individuals(object.children),
        siblings: serialize_related_individuals(object.siblings),
        spouses: serialize_related_individuals(object.spouses)
      }

      # Restore depth
      self.class.current_depth = current_depth

      # Remove from visited set when done with this branch
      self.class.visited_individuals.delete(object.id)

      result
    end
  end

  private

  def already_visited?
    self.class.visited_individuals.include?(object.id)
  end

  def max_depth_reached?
    self.class.current_depth >= self.class.recursion_depth
  end

  def serialize_related_individuals(individuals)
    individuals.map do |individual|
      if self.class.visited_individuals.include?(individual.id) || max_depth_reached?
        # Just return a reference if we've seen this individual before or at max depth
        { id: individual.id, name: individual.name, reference: true }
      else
        # Otherwise serialize the individual
        ActiveModelSerializers::SerializableResource.new(individual, serializer: IndividualSerializer).as_json
      end
    end
  end
end
