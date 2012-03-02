# filter coffee, har de har
class Filter
  constructor: (model, keywords...) ->
    @items = model.todos.filter (t) -> keywords.some((kw) -> t.text.match(///#{kw}///))
    @length = @items.length

module.exports = Filter
