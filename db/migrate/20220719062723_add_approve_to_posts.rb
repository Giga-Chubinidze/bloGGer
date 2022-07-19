class AddApproveToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :approval_status, :boolean, default: false
  end
end
