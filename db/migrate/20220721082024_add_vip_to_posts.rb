class AddVipToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :is_vip, :boolean, default: false
  end
end
