Model = class Model
  constructor: ->
    @todos = []
    @length = 0

  by_id: (id) ->
    return new Error("Element not in model") if id >= @length or id < 0
    return @todos[id]

  add: (item) ->
    @todos.push item
    @length++
    @

module.exports = Model
