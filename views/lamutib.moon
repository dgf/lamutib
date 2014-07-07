html = require "lapis.html"

class Layout extends html.Widget
  content: =>
    html_5 ->
      head ->
        title @title
      body ->
        h1 @title
        if @errors
          div class: "errors", ->
            ul ->
              for e in *@errors
                li e
        div class: "content", ->
          @content_for "inner"

