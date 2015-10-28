class RedmineAppendUsersDisplayFormatAddIndexUsers < ActiveRecord::Migration
  def change
    add_index :users, [:firstname, :lastname, :status, :type]
  end
end
