Todo = require '../lib/todo'

describe 'model', ->
  it 'should exist', ->
    expect(Todo.Model).toBeDefined()

  it 'should be instantiable', ->
    expect(typeof new Todo.Model).toEqual('object')

  describe 'when empty', ->
    model = {}
    beforeEach ->
      model = new Todo.Model

    it 'should have a length of zero', ->
      expect(model.length()).toEqual(0)

    it 'should give an error when trying to access elements', ->
      expect(model.by_id(0) instanceof Error).toBeTruthy()

    describe 'after adding one element', ->
      it 'should have a length of one', ->
        model.add('foobar')
        expect(model.length()).toEqual(1)

