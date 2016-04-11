apiPath = 'https://api.quipper.com'
$ = require('jquery')

class Api
  constructor: ->
    $.ajaxSetup
      beforeSend: (xhr, settings) =>
        xhr.setRequestHeader 'Authorization', "Token #{@token}"

  bootstrap: ->
    $.getJSON(apiPath + '/qlearn/v1/bootstrap', {})

  todos: ->
    $.getJSON(apiPath + '/qlearn/v1/todo', { active: 'true' })

  login: (username, password) ->
    token = window.btoa("#{username}:#{password}")

    $.ajax
      type: 'POST'
      url: apiPath + '/qlearn/v1/authorizations'
      dataType: 'json'
      data: JSON.stringify
        client_id: "G7I+OzPQk2dYsjZk/g+4Qw=="
        client_secret: "7gPE5QKlng4z79e7iN9e46SdqUToI9sWSEPHSbrsquFcaPz87Cj1/VgaCfgbNQKIbhX/E+hdNm+2L7X6R3hfsQ=="
        response_type: "json"
      beforeSend: (xhr, settings) ->
        xhr.setRequestHeader 'Authorization', "Basic #{token}"

module.exports = new Api()
