class CreateKids < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :net_id
      t.string :fname
      t.string :lname
      t.string :address
      t.string :phone

      t.timestamps null: false
    end
  end
end
