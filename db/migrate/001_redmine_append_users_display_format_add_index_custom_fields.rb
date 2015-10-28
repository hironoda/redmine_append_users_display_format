class RedmineAppendUsersDisplayFormatAddIndexCustomFields < ActiveRecord::Migration
  def change
    add_index :custom_fields, [:id, :type, :name]
  end
end
