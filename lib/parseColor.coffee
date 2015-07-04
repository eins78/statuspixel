isNumber = require('lodash/lang/isNumber')
isString = require('lodash/lang/isString')
every = require('lodash/collection/every')
Color= require('colour.js')

log= require('./logger')

module.exports= parseColor=(input)->
  return input if ['r', 'g', 'b'].every (key)-> input[key]

  rgb = switch
    when input?.length is 3 and every(input, (i)-> isNumber(i))
      input
    when isString(input)
      (new Color(input)).rgb255()
    else
      log.warn 'pixel: could not parse color!', input

  { r: rgb[0], g: rgb[1], b: rgb[2] } if rgb?
