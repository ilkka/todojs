class Todo
  constructor: (text) ->
    @done = false
    @text = text

  do: ->
    @done = true
    @text = 'x ' + @text.replace /^\(B\)\s+/, ""

  undo: ->
    @done = false
    @text = @text.replace /^x\s+/, ''


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
