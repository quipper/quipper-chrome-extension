View = require('./view.coffee')

class LoggedIn extends View
  template: require('../../templates/logged_in.hbs')

module.exports = new LoggedIn()
