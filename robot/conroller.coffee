RD = require("redis")
SP = require "serialport"

cfg = baudrate: 115200
sp = new SP.SerialPort "/dev/ttyACM0", cfg, false

rd = RD.createClient(6379, "vs43.ailove.ru")

rd.on "error", (err)->console.log err

commands = []
waitingTask = false

getNextTask = ()=>

    if not waitingTask    
        waitingTask = true
        rd.brpop "tasks", 0, (err, task)=>
            console.log err, task
            waitingTask = false
            if err
                console.log err
                return

            task = JSON.parse(task[1])
            commands = task.gcode.split("\n")
            console.log commands

addCheckSum = (cmd)->
    cs = 0
    for c in "#{cmd} "
        cs^=c.charCodeAt(0)
    "#{cmd} *#{cs&0xff}"

nextCommand = ()->
    if commands.length == 0
        getNextTask()
        return
    cmd = commands.shift()
    cmd = addCheckSum(cmd)
    console.log ">> [#{cmd}]"
    sp.write "#{cmd}\r\n", (err, res)->(console.log err if err)

buf =""
onData =(d)=>
    s = d.toString()
    buf += s
    # console.log {}, s, buf
    rn = buf.indexOf "\r\n"
    return if rn <0

    while rn >= 0
        ln = buf.substring(0,rn)
        console.log "<< [#{ln}]"
        if ln.indexOf("wait") is 0 or ln.indexOf("ok") is 0
            nextCommand()

        buf = buf.substring(rn+2)
        rn = buf.indexOf "\r\n"

onOpen = (err)=>
    if err
        return console.log err
    console.log "Opened"
    sp.on "data", onData
    getNextTask()

sp.open onOpen