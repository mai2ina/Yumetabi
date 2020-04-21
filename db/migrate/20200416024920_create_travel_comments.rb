class CreateTravelComments < ActiveRecord::Migration[5.2]
  def change
    create_table :travel_comments do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :travel, foreign_key: true

      t.timestamps
    end
  end
end
