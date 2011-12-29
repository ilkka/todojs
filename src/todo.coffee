class Todo
  constructor: (text) ->
    @done = false
    @text = text

  do: ->
    @done = true
    @text = @text.replace /^\(B\)\s+/, ""

class Model
  constructor: ->
    @todos = []

  by_id: (id) ->
    return new Error("Element not in model") if id >= @length() or id < 0
    return @todos[id]

  length: -> @todos.length

  add: (item) ->
    @todos.push item

exports.Model = Model
exports.Todo = Todo
