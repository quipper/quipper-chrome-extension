api = require('./api.coffee')
Todo = require('./todo.coffee')
View = require('./view.coffee')
_ = require('underscore')

class Todos extends View
  template: require('../../templates/todos.hbs')

  fetch: ->
    @$el.loading(true).addClass('p-y-lg')
    api.todos().done(_.bind(@fetched, @))

  fetched: (data) ->
    @$el.loading(false).removeClass('p-y-lg')
    @$el.empty()
    if data.length > 0
      todosCount = 0
      for todo in data
        if todo.todo_topic_ids and todo.todo_topic_ids.length > 0
          todo.icon = todo.learn_mode
          if todo.learn_mode == 'self_study'
            todo.icon = 'schedule'
          view = new Todo(todo)
          view.appendTo(@$el, todo)
          todosCount += 1
      chrome.browserAction.setBadgeText text: todosCount.toString()
    else
      chrome.browserAction.setBadgeText text: null

module.exports = new Todos()
