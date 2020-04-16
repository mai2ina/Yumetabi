class CreateDesks < ActiveRecord::Migration[5.2]
  def change
    create_table :desks do |t|
      t.string :name
      t.string :overview
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
