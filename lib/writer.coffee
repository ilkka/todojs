fs = require 'fs'

exports.write = (model, filename, callback) ->
  fs.writeFile filename,
    model.map((t) -> t.text).join("\n"),
    callback
