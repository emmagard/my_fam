class AddInverseTypeToRelatioshipType < ActiveRecord::Migration[8.0]
  def change
    add_reference :relationship_types, :inverse_type, foreign_key: { to_table: :relationship_types }
  end
end
