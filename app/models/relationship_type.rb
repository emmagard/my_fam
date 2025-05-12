class RelationshipType < ApplicationRecord
  PARENT = 'parent'.freeze
  CHILD  = 'child'.freeze
  SIBLING = 'sibling'.freeze

  
  MOTHER = 'Mother'.freeze
  FATHER = 'Father'.freeze

  SISTER = 'Sister'.freeze
  BROTHER = 'Brother'.freeze
  COUSIN = 'Cousin'.freeze
  SON = 'Son'.freeze
  DAUGHTER = 'Daughter'.freeze
  AUNT = 'Aunt'.freeze
  UNCLE = 'Uncle'.freeze

  # scope :parent_types, -> { where(value: PARENT_VALUES) }
  # scope :children_types, -> { where(value: CHILDREN_VALUES) }
  # scope :sibling_types, -> { where(value: SIBLING_VALUES) }
  # scope :cousin_type, -> { where(value: COUSIN) }
  # scope :aunt_type, -> { where(value: AUNT) }
  # scope :uncle_type, -> { where(value: UNCLE) }

  belongs_to :inverse_type, class_name: "RelationshipType", optional: true
  has_many :inverse_of, class_name: "RelationshipType", foreign_key: "inverse_type_id"

  has_many :relationships

  # def self.parent_types_ids
  #   RelationshipType.parent_types.pluck(:id)
  # end

  # def self.children_types_ids
  #   RelationshipType.children_types.pluck(:id)
  # end

  # def self.siblings_types_ids
  #   RelationshipType.sibling_types.pluck(:id)
  # end

  # def self.cousin_type_id
  #   RelationshipType.cousin_type.pluck(:id)
  # end

  # def self.aunt_type_id
  #   RelationshipType.aunt_type.pluck(:id)
  # end

  # def self.uncle_type_id
  #   RelationshipType.uncle_type.pluck(:id)
  # end
end
