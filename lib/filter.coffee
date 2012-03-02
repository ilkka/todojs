# filter coffee, har de har
class Filter
  constructor: (model, keywords...) ->
    @items = model.todos.filter (t) -> keywords.some((kw) -> kw in t.text)

  length: -> @items.length

module.exports = Filter
