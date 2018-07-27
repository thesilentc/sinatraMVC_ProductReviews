class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :review_comment
      t.boolean :recommend
      t.integer :rating
    end
  end
end
