Model = class Model
  constructor: ->
    @todos = []

  by_id: (id) ->
    return new Error("Element not in model") if id >= @length() or id < 0
    return @todos[id]

  length: -> @todos.length

  add: (item) ->
    @todos.push item
    @

module.exports = Model
