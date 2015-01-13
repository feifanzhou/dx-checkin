class AddNicknameToKids < ActiveRecord::Migration
  def change
    add_column :kids, :nickname, :string
  end
end
