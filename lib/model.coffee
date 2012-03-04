class Model
  constructor: ->
    @todos = []
    @length = 0

  byId: (id) ->
    return new Error("Element not in model") if id >= @length or id < 0
    return @todos[id]

  add: (item) ->
    @todos.push item
    @length++
    @

module.exports = Model
