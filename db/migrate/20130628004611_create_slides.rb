class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :title
      t.text :body
      t.integer :order
      t.integer :post_id
      t.integer :timing

      t.timestamps
    end
  end
end
