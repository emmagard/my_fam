class Individual < ApplicationRecord
  has_many :relationships
  has_many :relatives, through: :relationships, source: :relative

  has_many :inverse_relationships, class_name: "Relationship", foreign_key: "relative_id"
  has_many :inverse_relatives, through: :inverse_relationships, source: :individual

  # def parents_ids
  #   self.relationships.parents.pluck(:relative_id)
  # end

  # def siblings_ids
  #   self.relationships.siblings.pluck(:relative_id)
  # end

  # def children_ids
  #   self.relationships.children.pluck(:relative_id)
  # end
end
