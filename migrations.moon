import add_column, create_table, types from require "lapis.db.schema"

{
  [1]: =>
    create_table "estate", {
      { "id", types.serial }
      { "code", types.text unique: true }
      { "build", types.integer null: true }
      { "comment", types.text null: true }
      "PRIMARY KEY (id)"
    }
    create_table "address", {
      { "id", types.serial }
      { "street", types.varchar }
      { "zipcode", types.varchar }
      { "city", types.varchar }
      "PRIMARY KEY (id)"
    }
    add_column "estate", "address_id", types.foreign_key
}

