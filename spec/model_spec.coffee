Todo = require '../lib/todo'

describe 'model', ->
  it 'should exist', ->
    expect(Todo.Model).toBeDefined()

  it 'should be instantiable', ->
    expect(typeof new Todo.Model).toEqual('object')

  describe 'when empty', ->
    it 'should have a length of zero', ->
      expect((new Todo.Model).length()).toEqual(0)

    it 'should give an error when trying to access elements', ->
      expect(-> (new Todo.Model).by_id(0)).toThrow()
