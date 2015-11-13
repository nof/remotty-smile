class CreateFaces < ActiveRecord::Migration
  def change
    create_table :faces do |t|
      t.references :user, index: true, foreign_key: true
      t.string :image
      t.integer :smile

      t.timestamps null: false
    end
  end
end
