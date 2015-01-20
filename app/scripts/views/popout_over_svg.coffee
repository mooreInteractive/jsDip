$ = window.$

class window.PopoutOverSVG
  constructor: (targetEl=null, show=false) ->
    @$el = null
    @render()
    @target(targetEl) if targetEl
    @show() if show
    $(window).scroll @handleScroll

  target: (targetEl) ->
    @targetEl = $(targetEl)
    @position()

  render: () ->
    # overwrite me to render or attach to an existing element.
    # example below:
    @$el = $('<div class="popout">').html @htmlContent
    $('body').append @$el
    @hide()
    @$el.css("position": "fixed");

  htmlContent: ->
    throw "Not implemented"

  handleScroll: =>
    @position() if @$el

  position: (top=null, left=null) ->
    boundingRect = @targetEl[0].getBoundingClientRect()
    left = boundingRect.left + boundingRect.width
    top = boundingRect.top
    @$el.css(top: top, left: left)

  show: ->
    @$el.show()

  hide: ->
    @$el.hide()


