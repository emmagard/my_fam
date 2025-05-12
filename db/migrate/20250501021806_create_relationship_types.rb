class CreateRelationshipTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :relationship_types do |t|
      t.string :value
      
      t.timestamps
    end
  end
end
