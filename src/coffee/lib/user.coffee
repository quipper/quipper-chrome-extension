$ = require('jquery')
View = require('./view.coffee')
_ = require('underscore')

class User extends View
  template: require('../../templates/user.hbs')
  events:
    'click .js-logout': 'clickLogout'

  clickLogout: (e) ->
    e.preventDefault()
    $(@).trigger('q:logout')


module.exports = new User()
