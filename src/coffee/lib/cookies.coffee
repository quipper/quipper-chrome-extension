cookiePath = 'https://quipper.com/'
cookieName = 'learn_auth_token'

class Cookies
  set: (value) ->
    expirationDate = (new Date).getTime() / 1000 + 365 * 24 * 60 * 60
    chrome.cookies.set
      name: cookieName
      url: cookiePath
      value: value
      expirationDate: expirationDate

  remove: ->
    chrome.cookies.remove
      name: 'learn_auth_token'
      url: cookiePath

  get: (cb) ->
    chrome.cookies.get { name: cookieName, url: cookiePath }, cb

module.exports = new Cookies()
