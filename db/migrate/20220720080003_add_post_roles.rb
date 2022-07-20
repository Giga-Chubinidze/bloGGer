class AddPostRoles < ActiveRecord::Migration[7.0]
  def change
    create_table(:posts_roles, :id => false) do |t|
      t.references :post
      t.references :role
    end
  end
end
