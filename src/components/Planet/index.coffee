require './style'

{Component, createElement: ce} = require 'react'
{Entity} = require 'aframe-react'

# Earth constants
YEAR = 20000 # ms
RADIUS = 5 # m
DISTANCE = 50 # m

# Trail constants
TRAIL_COLOR = '#AAA'
TRAIL_THICKNESS = 0.0002 # coeff

# Label constants
LABEL_SIZE = 0.05 # coeff
LABEL_Y = 0.05 # coeff
LABEL_COLOR = 'white'

# Misc. constants
MIN_DIST = 50 # deg
MAX_TILT = 10 # deg

module.exports = class extends Component
  render: ->
    xr = Math.random() * MAX_TILT
    yr = Math.random() * 360
    zr = Math.random() * MAX_TILT
    dist = MIN_DIST + DISTANCE * @props.orbit.distance
    radius = RADIUS * @props.radius
    ce Entity,  # Angle
      rotation: [xr, yr, zr]
      ce Entity,  # 360 rotation
        animation:
          property: 'rotation'
          to: '0 360 0'
          easing: 'linear'
          loop: true
          dur: YEAR * @props.orbit.period
        ce Entity,  # Trail
          primitive: 'a-torus'
          rotation: '90 0 0'
          geometry:
            radius: dist
            radiusTubular: TRAIL_THICKNESS * dist
          material:
            color: TRAIL_COLOR
        ce Entity,  # Planet
          primitive: 'a-sphere'
          position: [0, 0, -dist]
          geometry:
            radius: radius
          material:
            color: @props.color
            src: "#asset-#{@props.name}"
          ce Entity,  # Label
            position: [-radius, LABEL_Y * dist + radius, 0]
            text:
              text: @props.name
              size: LABEL_SIZE * dist
            material:
              color: LABEL_COLOR