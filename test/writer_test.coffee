vows = require 'vows'
assert = require 'assert'
temp = require 'temp'
fs = require 'fs'
util = require 'util'
path = require 'path'
Model = require '../lib/model'
Todo = require '../lib/todo'
writer = require '../lib/writer'

vows
  .describe('the todo writer')
  .addBatch
    'given we have a directory':
      topic: ->
        tempdir = temp.mkdirSync 'todojs'
        throw err if util.isError(tempdir)
        tempdir

      'when we write an empty model':
        topic: (tempdir) ->
          fp = path.join tempdir, 'empty_model.txt'
          m = new Model
          writer.write m, fp, (err) =>
            this.callback err, fp

        'the file should be empty': (err, fp) ->
          assert.isFalse util.isError(err)
          assert.equal fs.readFileSync(fp, 'utf-8'), "\n"

      'when some todos are added':
        topic: (tempdir) ->
          fp = path.join tempdir, 'todos.txt'
          m = new Model()
          m.add(new Todo(t)) for t in [
            '(A) first', '(D) second +proj @ctx', '(B) @ctx third'
          ]
          writer.write m, fp, (err) =>
            this.callback err, fp

        'the file should contain the todos in order': (err, fp) ->
          assert.isFalse util.isError(err)
          data = fs.readFileSync(fp, 'utf-8')
          assert.isFalse util.isError(data)
          assert.equal data, "(A) first\n(D) second +proj @ctx\n(B) @ctx third"

  .export(module)
