load 'application'

before 'load image', ->
  Image.find params.id, (err, image) =>
    if err || !image
      if !err && !image && params.format == 'json'
        return send code: 404, error: 'Not found'
      redirect pathTo.images
    else
      @image = image
      next()
, only: ['show', 'edit', 'update', 'destroy']

action 'new', ->
  @image = new Image
  @title = 'New image'
  render()

action 'create', ->
  Image.create body.Image, (err, image) =>
    respondTo (format) =>
      format.json ->
        if err
          send code: 500, error: image.errors || err
        else
          send code: 200, data: image.toObject()
      format.html =>
        if err
          flash 'error', 'Image can not be created'
          @image = image
          @title = 'New image'
          render 'new'
        else
          flash 'info', 'Image created'
          redirect pathTo.images

action 'index', ->
  Image.all (err, images) =>
    @images = images
    @title = 'Image index'
    respondTo (format) ->
      format.json ->
        send code: 200, data: images
      format.html ->
        render images: images

action 'show', ->
  @title = 'Image show'
  respondTo (format) =>
    format.json =>
      send code: 200, data: @image
    format.html ->
      render()

action 'edit', ->
  @title = 'Image edit'
  respondTo (format) =>
    format.json =>
      send code: 200, data: @image
    format.html ->
      render()

action 'update', ->
  @image.updateAttributes body.Image, (err) =>
    respondTo (format) =>
      format.json =>
        if err
          send code: 500, error: @image.errors || err
        else
          send code: 200, data: @image
      format.html =>
        if !err
          flash 'info', 'Image updated'
          redirect path_to.image(@image)
        else
          flash 'error', 'Image can not be updated'
          @title = 'Edit image details'
          render 'edit'

action 'destroy', ->
  @image.destroy (error) ->
    respondTo (format) ->
      format.json ->
        if error
          send code: 500, error: error
        else
          send code: 200
      format.html ->
        if error
          flash 'error', 'Can not destroy image'
        else
          flash 'info', 'Image successfully removed'
        send "'" + path_to.images + "'"
