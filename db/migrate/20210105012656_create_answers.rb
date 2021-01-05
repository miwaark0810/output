class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|

      t.timestamps
      t.text :text,                null: false
      t.references :user,          foreign_key: true
      t.references :question,      foreign_key: true
    end
  end
end
