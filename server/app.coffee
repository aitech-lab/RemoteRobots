#!/usr/local/bin/coffee

#  run with > supervisor -w weserver.coffee webserver.coffee 
# http://mherman.org/blog/2013/11/10/social-authentication-with-passport-dot-js/#.VUIxfnV7jUY

express   = require 'express.io'
stylus    = require 'stylus'
nib       = require 'nib'
coffee    = require 'coffee-middleware'

pub    = __dirname + '/public'
views  = __dirname + '/views'

app  = do express
http = do app.http
io   = do app.io
io.set "origin", "*:*"


app.configure ->

    # static
    app.use express.static pub
    
    app.get '/*', (req, res, next) ->
        res.header "Access-Control-Allow-Origin", "*"
        res.header "Access-Control-Allow-Headers", "X-Requested-With"
        next()

    app.use express.cookieParser()
    app.use express.bodyParser()
    console.log express.session

    app.set 'views'      , views
    app.set 'view engine', 'jade'


    app.use stylus.middleware
        src       : pub
        compress  : true
        compile   : (str, path)->stylus(str).set('filename', path).use(nib())
        # debug   : true
        # force   : true

    app.use coffee
        src       : pub
        compress  : true
        # debug   : true

    app.use app.router

    app.use express.errorHandler()

app.get '/', (req, res)->

    res.render 'index', req: req

# app.io.route 'ready', (req)->
#     console.log "NEW USER AT #{req.data}"
#     req.io.join(req.data)
#     req.io.room(req.data).broadcast 'newuser'

# app.io.route 'word', (req)->
    
#     [bid,word] = req.data.split "/"
#     console.log "USER"+req
#     result = books.checkWord bid, word
#     console.log result
#     # result.user = req.user.displayName
#     app.io.room(bid).broadcast 'word', result

app.listen 7070
