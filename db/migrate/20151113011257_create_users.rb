class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.string :token
      t.string :icon_url
      t.string :room_key
      t.string :participation_key
      t.string :email

      t.timestamps null: false
    end
  end
end
