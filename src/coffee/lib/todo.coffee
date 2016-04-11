api = require('./api.coffee')
View = require('./view.coffee')
_ = require('underscore')

class Todo extends View
  template: require('../../templates/todo.hbs')
  constructor: (todo) ->
    @todo = todo

module.exports = Todo
