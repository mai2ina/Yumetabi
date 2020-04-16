class CreateTravelImages < ActiveRecord::Migration[5.2]
  def change
    create_table :travel_images do |t|
      t.string :image
      t.references :travel, foreign_key: true

      t.timestamps
    end
  end
end
