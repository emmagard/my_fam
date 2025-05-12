class Relationship < ApplicationRecord
  belongs_to :individual
  belongs_to :relative, class_name: "Individual"
  belongs_to :relationship_type

  after_create :create_inverse_relationship

  def create_inverse_relationship
    return unless relationship_type.inverse_type

    Relationship.find_or_create_by(
      individual: relative,
      relative: individual,
      relationship_type: relationship_type.inverse_type
    )
  end
end
