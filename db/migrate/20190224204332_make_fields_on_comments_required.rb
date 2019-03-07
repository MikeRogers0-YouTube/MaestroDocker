class MakeFieldsOnCommentsRequired < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :name, :string, null: false
    change_column :comments, :message, :string, null: false
  end
end
