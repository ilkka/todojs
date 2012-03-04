# filter coffee, har de har
Model = require './model'

class Filter extends Model
  constructor: (model, keywords...) ->
    @todos = model.todos.filter (t) -> keywords.some((kw) -> t.text.match(///#{kw}///))
    @length = @todos.length

module.exports = Filter
