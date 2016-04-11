$ = require('jquery')

window.templates = {
  todos: require('../templates/todos.hbs')
  todo: require('../templates/todo.hbs')
  user: require('../templates/user.hbs')
}

session = require('./lib/session.coffee')
cookies = require('./lib/cookies.coffee')
login   = require('./lib/login.coffee')
user    = require('./lib/user.coffee')
loggedIn= require('./lib/logged_in.coffee')
todos   = require('./lib/todos.coffee')


sessionStarted = (data) ->
  loggedIn.renderTo('body')
  user.renderTo(loggedIn.$('#user_region'), data.user)
  todos.renderTo(loggedIn.$('#todos_region'))
  todos.fetch()

sessionStopped = ->
  login.renderTo('body')
  session.stop()

document.addEventListener 'DOMContentLoaded', ->
  $(login).on('q:login', sessionStarted)
  $(user).on('q:logout', sessionStopped)

  cookies.get (cookie) ->
    if cookie
      session.start(decodeURIComponent(cookie.value)).then(sessionStarted, sessionStopped)
    else
      sessionStopped()
