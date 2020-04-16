class CreateTravels < ActiveRecord::Migration[5.2]
  def change
    create_table :travels do |t|
      t.string :name
      t.string :country
      t.string :prefecture
      t.string :city
      t.date :starts_on
      t.date :ends_on
      t.string :want_to_go
      t.string :want_to_do
      t.references :desk, foreign_key: true

      t.timestamps
    end
  end
end
