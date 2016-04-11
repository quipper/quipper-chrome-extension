cookies = require('./cookies.coffee')
api = require('./api.coffee')

class Session
  start: (token) ->
    @token = token
    cookies.set(token)
    api.token = token
    api.bootstrap()

  stop: ->
    @token = null
    cookies.remove()

module.exports = new Session()
