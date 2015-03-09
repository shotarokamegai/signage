Controller = require "./Controller"

class Video extends Controller

  constructor: (selector, src) ->
    @$el = $("#{ selector }")
    @src = src
    @max = src.length
    @cur = -1

  reset: ->
    @$el.empty()

  nextVideo: ->
    if @cur + 1 < @max
      @cur++
    else
      @cur = 0
    @src[@cur]

  ready: ->
    @reset()
    new Promise (resolve, reject) =>
      self = @
      video = @nextVideo()
      console.log "set video #{ video }"

      src = """<video src="#{ video }"></video>"""
      $(src).appendTo(@$el)
      .on "error", ->
        return reject(10)
      .on "stalled", ->
        self.stop()
        return reject(11)
      .on "abort", ->
        return reject(9)
      .on "loadeddata", ->
        return resolve(true)
      .on "ended", ->
        self.stop()

  play: ->
    @$el.find("video").get(0).currentTime = 0
    @$el.find("video").get(0).play()

  start: ->
    super()
    @play()

  stop: =>
    @tid = clearTimeout(@tid)
    @tid = null
    @.trigger "ended"

module.exports = Video
