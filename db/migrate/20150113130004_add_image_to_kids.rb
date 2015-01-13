class AddImageToKids < ActiveRecord::Migration
  def change
    add_column :kids, :image, :text
  end
end
