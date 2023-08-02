class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.integer :school_id, null: false
      t.boolean :active

      t.timestamps
    end
  end
end
