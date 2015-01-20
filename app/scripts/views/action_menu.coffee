$ = window.$
PopoutOverSVG = window.PopoutOverSVG

# Note, this is a work in progress. Click-action handling
# on the menu isn't done yet. Ideally, the menu will listen to
# clicks on its links -- and publish an event to interested
# subscribers.
#
# How to use me:
#   actionMenu = new ActionMenu()
#   actionMenu.setState('movements') # or 'adjustments'
#   actionMenu.target(svgElementForUnit)
#   actionMenu.show()
class window.ActionMenu extends PopoutOverSVG
  htmlContent:
    # TODO(rkofman): use a real templating solution.
    $("#map_actions").html()

  setState: (newState) ->
    allStates = ["movements", "adjustments"]
    for state in allStates
      container = @$el.find(".#{state}")
      if newState == state
        container.show()
      else
        container.hide()
