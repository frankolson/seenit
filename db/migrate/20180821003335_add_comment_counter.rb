class AddCommentCounter < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :comments_count, :integer, null: false, default: 0
    add_column :comments, :comments_count, :integer, null: false, default: 0
  end
end
