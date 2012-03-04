class Model
  constructor: ->
    @todos = []
    @length = 0
    @nextId = 1

  byId: (id) ->
    result = null
    @todos.forEach (t) ->
      if t.id is id
        result = t
    if result
      return result
    return new Error("Not found")

  add: (item) ->
    item.id = @nextId++
    @length = @todos.push(item)
    @

module.exports = Model
