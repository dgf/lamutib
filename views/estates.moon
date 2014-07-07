html = require "lapis.html"

class EstateList extends html.Widget

  content: =>
    a href: @url_for("new_estate"), "Add"
    ul ->
      for estate in *@estates
        li ->
          a href: @url_for("estate", code: estate.code), estate.code

