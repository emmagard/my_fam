class AddIndividualToRelationships < ActiveRecord::Migration[8.0]
  def change
    add_reference :relationships, :individual, null: false, foreign_key: { to_table: :individuals }
  end
end
