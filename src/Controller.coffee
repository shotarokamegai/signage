
class Controller extends EventEmitter

  start: ->
    @$el.addClass "active"

  close: ->
    @$el.removeClass "active"

module.exports = Controller