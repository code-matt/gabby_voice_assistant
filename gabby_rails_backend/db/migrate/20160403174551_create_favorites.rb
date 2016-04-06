class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :name, null: false
      t.belongs_to :user, null: false
    end
  end
end
