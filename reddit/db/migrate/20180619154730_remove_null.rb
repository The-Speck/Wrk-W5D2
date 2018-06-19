class RemoveNull < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :url, :string, null: false
  end
end
