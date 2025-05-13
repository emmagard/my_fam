class Individual < ApplicationRecord
  # Relationships inititated by this individual
  has_many :relationships
  has_many :relatives, through: :relationships, source: :relative

  # Relationships where this individual is the target
  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "relative_id"
  has_many :inverse_relatives, through: :inverse_relationships, source: :individual

  def parents
    Individual.joins({ inverse_relationships: :relationship_type })
      .where(relationships: { individual_id: id })
      .where(relationship_types: { value: "parent" })
  end

  def children
    Individual.joins({ inverse_relationships: :relationship_type })
      .where(relationships: { individual_id: id })
      .where(relationship_types: { value: "child" })
  end

  def siblings
    Individual.joins({ inverse_relationships: :relationship_type })
      .where(relationships: { individual_id: id })
      .where(relationship_types: { value: "sibling" })
  end

end
