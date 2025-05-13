class RelationshipType < ApplicationRecord
  PARENT = "parent".freeze
  CHILD  = "child".freeze
  SIBLING = "sibling".freeze


  MOTHER = "Mother".freeze
  FATHER = "Father".freeze

  SISTER = "Sister".freeze
  BROTHER = "Brother".freeze
  COUSIN = "Cousin".freeze
  SON = "Son".freeze
  DAUGHTER = "Daughter".freeze
  AUNT = "Aunt".freeze
  UNCLE = "Uncle".freeze

  belongs_to :inverse_type, class_name: "RelationshipType", optional: true
  has_many :inverse_of, class_name: "RelationshipType", foreign_key: "inverse_type_id"

  has_many :relationships

  scope :parent, -> { find_by(value: "parent") }
  scope :child, -> { find_by(value: "child") }
  scope :sibling, -> { find_by(value: "sibling") }
end
