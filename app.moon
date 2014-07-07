lapis = require "lapis"
util = require "lapis.util"

import assert_valid from require "lapis.validate"
import Model from require "lapis.db.model"
import
  capture_errors
  respond_to
  from require "lapis.application"

class Address extends Model
class Estate extends Model

lapis.serve class extends lapis.Application

  layout: require "views.lamutib"

  handle_404: =>
    "404 not found", status: 404

  [estates: "/"]: =>
    @title = "estates"
    @estates = Estate\select!
    render: true

  [estate: "/estate/:code"]: =>
    @e = Estate\find code: @params.code
    return "estate not found", status: 404 unless @e
    @a = Address\find @e.address_id
    @title = "estate " .. @e.code
    render: true

  [new_estate: "/estate"]: respond_to {
    GET: =>
      @title = "create an estate"
      render: true
    POST: capture_errors =>
      assert_valid @params, {
        { "code", exists: true, min_length: 3, max_length: 17 }
        { "build", optional: true, is_integer: true }
        { "comment", optional: true, min_length: 3, max_length: 37 }
        { "street", min_length: 3, max_length: 17 }
        { "zipcode", min_length: 5, max_length: 5 }
        { "city", min_length: 3, max_length: 17 }
      }
      a = Address\create
        street: @params.street
        zipcode: @params.zipcode
        city: @params.city
        country: @params.country
      Estate\create
        address_id: a.id
        code: @params.code
        build: @params.build
        comment: @params.comment
      redirect_to: @url_for "estates"
  }

