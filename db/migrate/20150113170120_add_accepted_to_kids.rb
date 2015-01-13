class AddAcceptedToKids < ActiveRecord::Migration
  def change
    add_column :kids, :is_accepted, :boolean
  end
end
