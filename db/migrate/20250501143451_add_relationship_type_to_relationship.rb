class AddRelationshipTypeToRelationship < ActiveRecord::Migration[8.0]
  def change
    add_reference :relationships, :relationship_type, null: false, foreign_key: true
  end
end
