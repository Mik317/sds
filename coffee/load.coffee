###
000       0000000    0000000   0000000  
000      000   000  000   000  000   000
000      000   000  000000000  000   000
000      000   000  000   000  000   000
0000000   0000000   000   000  0000000  
###

fs    = require 'fs'
chalk = require 'chalk'
path  = require 'path'

err  = (msg) -> console.log chalk.red("\n"+msg+"\n")

load = (p) ->
    
    extname = path.extname p
    if extname == '.plist'
        require('simple-plist').readFileSync p
    else
        str = fs.readFileSync p, 'utf8'
        if str.length <= 0
            err "empty file: #{chalk.yellow.bold(p)}"
            return null 
            
        switch extname
            when '.json' then JSON.parse str
            when '.cson' then require('cson').parse str
            when '.noon' then require('noon').parse str
            when '.yml', '.yaml' then require('js-yaml').load str
            else
                require('noon').parse str

module.exports = load
