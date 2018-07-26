csv = require 'fast-csv'
fs = require 'fs'
sharinpix = require 'sharinpix'
async = require 'async'
_ = require 'lodash'

importImages = (path)->
  readStream = fs.createReadStream path
  albums = []
  import_id = Math.round(Math.random()*10000)
  
  csv
    .fromStream readStream, delimiter: ';'
    .on 'data', (data)->
      if _.keys(data).length != 4
        console.error "#{data.join(';')} must have 4 columns."
      else
        [album_id, url, tags, metadatas] = _.values data
        try
          json = JSON.parse metadatas
        catch error
          errorFlag = true
          console.error "#{album_id};#{url};#{tags};#{metadatas}"
        unless errorFlag
          albums.push async.reflect (callback) ->
            json['import_id'] = import_id
            sharinpix.get_instance().post '/imports',
              import_type: 'url'
              album_id: album_id
              url: url
              tags: _.split(tags, ',')
              metadatas: json
            .then (res)->
              { album_id, url, tags, metadatas } = res.params
              console.log "#{album_id};#{url};#{tags};#{JSON.stringify metadatas}"
              callback null, res
            , (err) ->
              callback err, null
            .catch (err)->
              metadatas = JSON.stringify metadatas
              console.error "#{album_id};#{url};#{tags};#{metadatas}"
    .on 'end', ->
      async.parallelLimit albums, 10
module.exports = importImages