class Model
  constructor: ->
    @todos = []

  by_id: (id) ->
    return new Error("Element not in model") if id >= @length() or id < 0

  length: -> @todos.length

exports.Model = Model
