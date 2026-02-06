class RelationshipSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :relative, serializer: IndividualSerializer
end