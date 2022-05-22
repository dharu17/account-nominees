# frozen_string_literal: true

class CreateNominees < ActiveRecord::Migration[6.1]
  def change
    create_table :nominees do |t|
      t.references :nominee, references: :accounts, type: :bigint, foreign_key: { to_table: :accounts }
      t.references :account, references: :accounts, type: :bigint, foreign_key: { to_table: :accounts }
      t.float :weightage
      t.timestamps
    end
  end
end
