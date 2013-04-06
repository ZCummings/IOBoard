class AddRememberMeToTable < ActiveRecord::Migration
  def change
  	add_column :users, :remeber_me, :bool, :null => false, :default => false
  end
end
