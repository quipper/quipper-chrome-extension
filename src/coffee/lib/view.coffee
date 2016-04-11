$ = require('jquery')
_ = require('underscore')

# A very simplified implementation of a View.
# It can render itself, and delegate events to the view.
class View
  template: ->
  events: {}

  render: (data) ->
    @$el = $(@template(data))

    if @events
      for key, func of _.result(@, 'events')
        if key.indexOf(' ') > -1
          event = key.substr(0, key.indexOf(' '))
          selector = key.substr(key.indexOf(' ')+1)
        else
          event = key
          selector = null
        @$el.on(event, selector, _.bind(@[func], @))
    @

  renderTo: (container, data) ->
    @render(data) unless @$el
    @$el.appendTo $(container).empty()
    @

  appendTo: (container, data) ->
    @render(data) unless @$el
    @$el.appendTo $(container)
    @

  $: (selector) ->
    @$el.find(selector)

module.exports = View
