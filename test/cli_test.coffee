vows = require 'vows'
assert = require 'assert'
util = require 'util'
execFile = require('child_process').execFile
temp = require 'temp'
fs = require 'fs'
path = require 'path'

scriptfile = if process.platform is 'win32' then 'todo.bat' else 'todo'

run = (args, callback) ->
  execFile(scriptfile, args, {cwd: __dirname + '/../bin'}, callback)
  return

vows
  .describe('the CLI')
  .addBatch
    'given a dir':
      topic: ->
        temp.mkdir('todojs', @callback)

      'and a todo file with one todo':
        topic: (dir) ->
          filename = path.join(dir, 'todo.txt')
          fs.writeFileSync(filename, '(A) my only todo @ctx')
          filename

        'when listing todos':
          topic: (filename) ->
            run(['-f', filename, 'ls'], @callback)

          'should exit with code zero': (err, stdout, stderr) ->
            assert.isNull err

          'should output the todos': (err, stdout, stderr) ->
            assert.equal stdout, "eka\ntoka\nkolmas\n"

  .export(module)
