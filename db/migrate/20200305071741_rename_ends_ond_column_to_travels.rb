class RenameEndsOndColumnToTravels < ActiveRecord::Migration[5.2]
  def change
    rename_column :travels, :ends_ond, :ends_on
  end
end
