class AddUserIdToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :user_id, :integer, index: true
  end
end
