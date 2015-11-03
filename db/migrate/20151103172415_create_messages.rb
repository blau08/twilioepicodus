class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.column :to, :string
      t.column :from, :string
      t.column :body, :text
      t.column :status, :string

      t.timestamps null: false
    end
  end
end
