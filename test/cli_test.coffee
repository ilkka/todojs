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

todofilecontents = """(A) my most important todo @ctx
(B) another todo +project
Third todo +project @ctx"""

vows
  .describe('the CLI')
  .addBatch
    'given a dir':
      topic: ->
        temp.mkdir('todojs', @callback)

      'and a todo file with some todos':
        topic: (dir) ->
          filename = path.join(dir, 'todo.txt')
          fs.writeFileSync(filename, todofilecontents)
          filename

        'when listing todos':
          topic: (filename) ->
            run(['-f', filename, 'ls'], @callback)

          'exits with code zero': (err, stdout, stderr) ->
            assert.isNull err

          'prints the todos to stdout': (err, stdout, stderr) ->
            assert.equal stdout, todofilecontents + "\n"

        'when listing todos with a keyword':
          topic: (filename) ->
            run ['-f', filename, 'ls', '@ctx'], @callback

          'prints only those todos that have the keyword': (err, stdout, stderr) ->
            assert.equal stdout, "(A) my most important todo @ctx\nThird todo +project @ctx\m"

  .export(module)
