fs = require 'fs'

exports.write = (model, filename, callback) ->
  fs.writeFile filename,
    (model.byId(i).text for i in [0..model.length-1]).join("\n"),
    callback
