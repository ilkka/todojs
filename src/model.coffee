priority_regex = /^(\([A-Z]\))\s+/

exports.Todo = class Todo
  constructor: (text) ->
    @done = false
    @text = text

  do: ->
    @done = true
    @text = 'x ' + @text.replace priority_regex, ""
    @

  undo: ->
    @done = false
    @text = @text.replace /^x\s+/, ''
    @

  set_priority: (priority) ->
    return new Error('Done items cannot be prioritized') if @done
    priobit =  if priority? then '(' + priority + ') ' else ''
    @text = priobit + @text.replace priority_regex, ''
    @

  prepend: (text) ->
    parts = @text.match(priority_regex)[1..]
    @text = parts[0] + " " + text + " " + @text.replace(priority_regex, '')
    @

  append: (text) ->
    @text = @text + " " + text
    @

exports.Model = class Model
  constructor: ->
    @todos = []

  by_id: (id) ->
    return new Error("Element not in model") if id >= @length() or id < 0
    return @todos[id]

  length: -> @todos.length

  add: (item) ->
    @todos.push item
    @
