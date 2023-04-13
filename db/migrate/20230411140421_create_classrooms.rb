class CreateClassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :classrooms do |t|
      t.integer :city, null: false, default: ""

      t.timestamps
    end
  end
end
