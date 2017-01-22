setscreen ("graphics:639;400")

fork PlaySoundLoop (titlemusic)
loop
    setscreen ("offscreenonly")
    titlescreen
    if rules then
        setscreen ("nooffscreenonly")
        loop
            if page = 1 then
                page1
            end if
            if page = 2 then
                page2
            end if
            if page = 3 then
                page3
            end if
            if page = 4 then
                page4
            end if
            exit when page = 0 or page = 5
        end loop
    else
        exit
    end if
    if page = 5 then
        setscreen ("offscreenonly")
        exit
    end if
end loop
cls
Pic.ScreenLoad ("background.bmp",0,0,picCopy)
Music.PlayFileStop


