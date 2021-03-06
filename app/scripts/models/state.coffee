root = exports ? this

_ = require 'underscore'

GameDate = require './date'
Unit = require './unit'

module.exports = class State
  # @date Date in the game.
  # @activePowers List of powers participating in the game. Could be a subset
  #               of belligerents if not all powers are playing.
  # @supplyCenters Map of powers to List of supply centers. TODO(cosmic): Make this a list.
  # @forces List of Units present.
  constructor: (info) ->
    for key, val of info when val? and key in ['activePowers', 'supplyCenters']
      @[key] = val
    @supplyCenters ?= {}

    @date = new GameDate info.date

    @forces = []
    for owner, forceTypes of info.forces
      for type, forces of forceTypes
        for loc in forces
          @forces.push new Unit {'loc': loc, 'type': type, 'owner': owner}

    @counts = {}
    # TODO(cosmic): Should do counts for all powers, not just active ones.
    for power in @activePowers
      # Count SCs.
      @counts[power] = {}
      @counts[power].supplyCenters = @supplyCenters[power]?.length ? 0

      # Count forces
      @counts[power].forces = (f for f in @forces when f.owner is power).length
      @counts[power].adjustment = @counts[power].supplyCenters - @counts[power].forces

  forcesAt: (loc) ->
    return (unit for unit in @forces when unit.loc is loc)

  forceAt: (loc) ->
    forces = @forcesAt loc
    if forces.length > 1
      throw "Multiple forces: #{forces} at #{loc}."
    return forces[0]

  forcesOfPower: (pow) ->
    return (unit for unit in @forces when unit.owner is pow)
