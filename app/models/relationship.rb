class Relationship < ApplicationRecord
  # scope :parents, -> { includes(:relationship_type).where(relationship_type_id: RelationshipType.parent_types_ids) }
  # scope :children, -> { where(relationship_type_id: RelationshipType.children_types_ids) }
  # scope :siblings, ->  { where(relationship_type_id: RelationshipType.siblings_types_ids) }

  belongs_to :individua
  belongs_to :relative, class_name: "individual"
  belongs_to :relationship_type

  # has_one :relative, class_name: "Individual"
end
