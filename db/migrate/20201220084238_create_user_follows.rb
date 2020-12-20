class CreateUserFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :user_follows do |t|
      t.references :requester, index: true, foreign_key: { to_table: :users }
      t.references :addressee, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
