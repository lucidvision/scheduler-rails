class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :director
      t.string :phone
      t.string :roles, array: true

      t.timestamps null: false
    end
  end
end
