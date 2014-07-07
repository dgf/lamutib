import
  close_test_server
  load_test_server
  request
  from require "lapis.spec.server"

describe "app", ->

  code = "estate_" .. os.time os.date "*t"

  setup ->
    load_test_server!

  teardown ->
    close_test_server!

  it "creates a new estate", ->
    status, body, headers = request "/estate", post:
      code: code
      build: 2014
      street: "Street 17"
      zipcode: "12345"
      city: "Berlin"
    assert.same 302, status
    assert.same headers.location, "http://127.0.0.1/"

  it "list the estate on index", ->
    status, body = request "/"
    assert.same 200, status
    assert.same code, string.match body, code

  it "views the estate", ->
    status, body = request "/estate/" .. code
    assert.same 200, status
    assert.same code, string.match body, code

