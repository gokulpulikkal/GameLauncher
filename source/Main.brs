
sub Main()
    print "in showChannelSGScreen"
    'Indicate this is a Roku SceneGraph application'
    m.screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    m.screen.setMessagePort(m.port)

    m.global = m.screen.getGlobalNode()
    m.global.id = "GlobalNode"

    m.global.addField("gameRequest", "int", true)
    m.global.observeField("gameRequest", m.port)

    m.screen.CreateScene("HomeScene")
    m.screen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if (msgType = "roSGNodeEvent")
            field = msg.getField()
            data = msg.getData()
            if (field = "gameRequest")
                onGameSelected(data)
            end if
        end if
    end while
end sub

function onGameSelected(gameIndex) as void
    if gameIndex = 0
        startTheSnakeGame()
    end if
end function

function startTheSnakeGame()
    app=newSnakeApp()
    dfDrawMessage(app.screen, app.bitmapset.regions["title-screen"])
    app.screen.swapbuffers()
    while true
        msg=wait(0, app.msgport)
        if type(msg)="roUniversalControlEvent" then exit while
    end while
    while true
        app.GameReset()        
        app.EventLoop()
        app.GameOverSound.Trigger(100)
        if app.GameOver() then ExitWhile
    end while
    m.screen.show()
end function
