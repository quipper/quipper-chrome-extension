$ = require('jquery')
api = require('./api.coffee')
session = require('./session.coffee')
View = require('./view.coffee')
_ = require('underscore')

class Login extends View
  template: require('../../templates/login.hbs')
  events:
    'submit': 'login'

  render: ->
    super
    @$('.alert').hide()

  login: (e) ->
    e.preventDefault()
    @$('.btn-primary').loading(true)
    username = @$('[name=username]').val()
    password = @$('[name=password]').val()
    api.login(username, password).then(_.bind(@loggedIn, @), _.bind(@failed, @))

  loggedIn: (data) ->
    @$('.btn-primary').loading(false)
    session.start(data.access_token).then(_.bind(@bootstrapped, @), _.bind(@failed, @))

  bootstrapped: (data) ->
    $(@).trigger('q:login', data)

  failed: ->
    @$('.btn-primary').loading(false)
    @$('.alert').slideDown()

module.exports = new Login()
