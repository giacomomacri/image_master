fs = require('fs')

module.exports = (compound, Image) ->
  Image.directory = -> compound.app.root + '/data'
  Image::filename = ->
    return 'dsd/' + @photo
