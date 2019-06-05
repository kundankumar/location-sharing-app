class AddSharedWithToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :shared_with, :string, array: true, default: []
  end
end
