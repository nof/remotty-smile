class ChangeSmileTypeToFace < ActiveRecord::Migration
  def up
    change_column :faces, :smile, :float, null: false, default: 0
  end

  def down
    change_column :faces, :smile, :integer, null: true, default: 0
  end
end
