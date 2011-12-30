class Todo
  constructor: (text) ->
    @done = false
    @text = text
    @priority_regex = /^\([A-Z]\)\s+/

  do: ->
    @done = true
    @text = 'x ' + @text.replace @priority_regex, ""
    @

  undo: ->
    @done = false
    @text = @text.replace /^x\s+/, ''
    @

  set_priority: (priority) ->
    return new Error('Done items cannot be prioritized') if @done
    priobit =  if priority? then '(' + priority + ') ' else ''
    @text = priobit + @text.replace @priority_regex, ''
    @


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
