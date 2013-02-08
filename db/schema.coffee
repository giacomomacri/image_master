# Example of model definition:
#
#define 'User', ->
#  property 'email', String, index: true
#  property 'password', String
#  property 'activated', Boolean, default: false
#

Image = describe 'Image', ->
    property 'title', String
    property 'photo', String
    set 'restPath', pathTo.images

