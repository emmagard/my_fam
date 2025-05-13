class IndividualSerializer < ActiveModel::Serializer
  attributes :id,
             :name

  has_many :parents
  has_many :children
  has_many :siblings
end
