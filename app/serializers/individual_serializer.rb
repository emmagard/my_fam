class IndividualSerializer < ActiveModel::Serializer
  attributes :id,
             :parents,
             :name,
             :siblings,
             :children

 def parents
  ids = Individual.find(object.parents_ids)
  ActiveModelSerializers::SerializableResource.new(ids, each_serializer: IndividualSerializer)
 end

 def siblings
  ActiveModelSerializers::SerializableResource.new(Individual.find(object.siblings_ids), each_serializer: IndividualSerializer)
 end

 def children
  ActiveModelSerializers::SerializableResource.new(Individual.find(object.children_ids), each_serializer: IndividualSerializer)
 end
end
