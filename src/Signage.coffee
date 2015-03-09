class Signage

  constructor: (scenes = [], order = []) ->
    @cur = 0
    @scenes = scenes
    @order = order
    @max = @order.length
    @scene = @scenes[@order[@cur]]

    for scene in @scenes
      #observer
      scene.on "ended", @onEnd

  onEnd: =>
    @next()

  start: ->
    @scene.ready()
    .then((rs) =>
      @scene.start()
    ).catch(@error)


  error: =>
    @next()

  getNextScene: ->
    if @cur + 1 < @max
      @cur++
    else
      @cur = 0
    @scenes[@order[@cur]]

  change: (next)->
    @scene.close()
    @scene = next
    @scene.start()

  next: ->
    nextScene = @getNextScene()
    if nextScene is @scene
      @scene.start()
    else
      nextScene.ready()
      .then((rs) =>
        @change(nextScene)
      )
      .catch(@error)

module.exports = Signage
