class AddTimestampsToArticles < ActiveRecord::Migration[8.0]
  def change
    change_table :articles do |t|
      t.timestamps
    end
  end
end
