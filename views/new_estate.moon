import Widget from require "lapis.html"

class Index extends Widget

  content: =>
    form method: "POST", action: @url_for("new_estate"), ->
      fieldset ->
        label ->
          text "code"
          input type: "text", name: "code", value: @params.code
        label ->
          text "build"
          input type: "text", name: "build", value: @params.build
      fieldset ->
        label ->
          text "street"
          input type: "text", name: "street", value: @params.street
        label ->
          text "zipcode"
          input type: "text", name: "zipcode", value: @params.zipcode
        label ->
          text "city"
          input type: "text", name: "city", value: @params.city
      fieldset ->
        label ->
          text "comment"
          textarea name: "comment", @params.comment
      button type: "submit", "add"

