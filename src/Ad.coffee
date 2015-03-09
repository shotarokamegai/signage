Controller = require "./Controller"

class Ad extends Controller

  @timeout: 15000

  constructor: (selector, @sources) ->
    @$el = $("#{ selector }")
    @tid = ""
    @sources
    @max = @sources.length
    @cur = -1

  next: ->
    if @cur + 1 < @max
      @cur++
    else
      @cur = 0
    @sources[@cur]

  ready: ->
    self = @
    new Promise (resolve, reject) =>
      src = @next()
      img = new Image()
      $(img).on 'load', ->
        self.$el.html img
        resolve()
      img.src = src

  start: ->
    super()
    @tid = setTimeout @stop, Ad.timeout

  stop: =>
    @tid = clearTimeout(@tid)
    @tid = null
    @trigger "ended"

module.exports = Ad
