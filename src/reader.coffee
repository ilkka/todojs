model = require './model'
fs = require 'fs'
util = require 'util'

exports.read = (filename, callback) ->
  fs.readFile filename, 'utf-8', (err, data) ->
    unless util.isError(err)
      mdl = new model.Model()
      mdl.add(new model.Todo(t)) for t in data.split(/\n/).filter((s)->s.trim().length > 0)
    callback(err, mdl)

