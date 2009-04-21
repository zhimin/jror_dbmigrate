class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table "addresses", :force => true do |t|
      t.string   "address_line1"
      t.string   "address_line2"
      t.string   "suburb"
      t.string   "state"
      t.string   "postcode"
      t.string   "country",          :default => "Australia"
      t.integer  "addressable_id"
      t.string   "addressable_type"
      t.timestamps
      t.datetime "deleted_at"
    end

    add_index "addresses", ["suburb"], :name => "index_addresses_on_suburb"

  end

  def self.down
    raise "This is the initial schema"
  end

end
