
#IfWinActive Netflix
WheelUp::volumeUp()
WheelDown::volumeDown()
volumeUp(mspeed=0,volume_delta=15)
{
    volumeDelta(mspeed,+volume_delta)
}
    
volumeDown(mspeed=0,volume_delta=15)
{
    volumeDelta(mspeed,-volume_delta)
}
volumeDelta(mspeed=5,delta=25)
{
    ; MouseMove, 5, 5, 50, R
    WinGetActiveStats Title, Width, Height, X, Y
    if (Title != "Netflix")
        Return
    SearchX1 := Width-300
    SearchY1 := 0
    SearchX2 := Width
    SearchY2 := Height/2
    ImageSearch, FoundX, FoundY, SearchX1, SearchY1, SearchX2, SearchY2,*128 netflix_app_volume_icon.png
    if (ErrorLevel = 2)
        displayMsg("Could not conduct the search.")
    else if (ErrorLevel = 1)
        displayMsg("Volume icon could not be found on the screen.")
    else
    {
        IconX := FoundX+17
        IconY := FoundY+17
        ImageSearch, FoundX, FoundY, SearchX1, SearchY1, SearchX2, SearchY2,*128 netflix_app_volume_handle.png
        if (ErrorLevel = 2)
            displayMsg("Could not conduct the search.")
        else 
        {
            if (ErrorLevel = 1)
            {
                MouseMove,IconX,IconY,mspeed
                Click
                ImageSearch, FoundX, FoundY, SearchX1, SearchY1, SearchX2, SearchY2,*128 netflix_app_volume_handle.png
            }
            if (ErrorLevel = 2)
                displayMsg("Could not conduct the search.")
            else if (ErrorLevel = 1)
                displayMsg("Volume handle could not be found on the screen.")
            else
            {
                IconX := FoundX+20
                IconY := FoundY+20
                MouseMove,IconX,IconY,mspeed
                MouseClickDrag,Left,0,0,0,-delta,mspeed,R
            }
        }
    }
    return
}
; http://www.autohotkey.com/board/topic/18042-simple-message-on-top-for-a-delayed-time/
displayMsg(text, time=2000)
{
    Gui, +AlwaysOnTop +ToolWindow -SysMenu -Caption
    Gui, Color, ffffff ;changes background color
    Gui, Font, 000000 s20 wbold, Verdana ;changes font color, size and font
    Gui, Add, Text, x0 y0, %text% ;the text to display
    Gui, Show, NoActivate, Xn: 0, Yn: 0

    sleep, time
    Gui, Destroy
}
#IfWinActive