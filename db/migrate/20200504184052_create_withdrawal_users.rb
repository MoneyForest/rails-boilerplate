# frozen_string_literal: true

class CreateWithdrawalUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :withdrawal_users do |t|
      t.integer :user_id,           null: false, default: 0
      t.string :email,              null: false, default: ''
    end
  end
end
