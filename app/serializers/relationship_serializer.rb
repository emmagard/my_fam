class RelationshipSerializer < ActiveModel::Serializer
  attributes :id,
             :relative


  def relative
    ActiveModelSerializers::SerializableResource.new(object.relative_id, serializer: IndividualSerializer)
  end
end
