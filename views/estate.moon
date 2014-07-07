import Widget from require "lapis.html"

class Estate extends Widget

  content: =>
    dl class: "details", ->
      dt "build"
      dd @e.build
      dt "comment"
      dd @e.comment
    dl class: "address", ->
      dt "street"
      dd @a.street
      dt "city"
      dd @a.zipcode .. " " .. @a.city

