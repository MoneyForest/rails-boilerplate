# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :display_name, :string, default: 'anonymous'
    add_column :users, :icon_image_path, :string, limit: 2000
    add_column :users, :background_image_path, :string, limit: 2000
    add_column :users, :profile, :text
    add_column :users, :name, :string
    add_column :users, :birthday, :datetime
    add_column :users, :gender, :string
    add_column :users, :zip_code, :integer
    add_column :users, :address, :string
    add_column :users, :job, :string
    add_column :users, :memo, :text
  end
end
