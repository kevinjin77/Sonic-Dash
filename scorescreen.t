
var playagain : int := Pic.FileNew ("Pics/playagain.bmp")
var gold : int := RGB.AddColor (232/256,214/256,16/256)
var silver : int := RGB.AddColor (191/256,190/256,178/256)
var bronze : int := RGB.AddColor (110/256,30/256,30/256)
var width, textTemp, font3 : int := 0
font3 := Font.New ("Small Fonts:14")

var scoretimer : real := 0

var dancepic : array 1 .. 7 of int
for i : 1 .. 7
    dancepic(i) := Pic.FileNew ("Pics/dance"+intstr(i)+".bmp")
end for
    
var highscorepic : array 1 .. 7 of int
for i : 1 .. 7
    highscorepic(i) := Pic.FileNew ("Pics/highscore"+intstr(i)+".bmp")
end for
    
var dancesprite : int := Sprite.New (dancepic(1))
var highscoresprite : int := Sprite.New (highscorepic(1))
Sprite.Hide (lifebar)
Sprite.Hide (shielded)
Sprite.Hide (ringicon)
Sprite.Hide (shoesicon)
Sprite.Hide (sonic)
Sprite.Hide (ringsprite)
Sprite.Hide (crabsprite)
Sprite.Hide (batsprite)
Sprite.Hide (bunnysprite)
Sprite.Hide (lancersprite)
Sprite.Hide (ghostsprite)
Sprite.Hide (ringspowerupsprite)
Sprite.Hide (lifepowerupsprite)
Sprite.Hide (shoespowerupsprite)
Sprite.Hide (shieldpowerupsprite)
Sprite.Hide (eggman)
Sprite.Hide (eggmanbat)
Sprite.Hide (eggmanlancer)
Sprite.Hide (eggmanbunny)
Sprite.Hide (eggmanghost)

%var score, finaltime, rings : int := 123
fork PlaySoundLoop (gameover)
Pic.ScreenLoad ("Pics/gameover.bmp",0,0,picCopy)
delay (1000)
Font.Draw ("Enemies Passed: ", 350, 250, font3, white)
Font.Draw (intstr(score), 530, 250, font3, white)
delay (1000)
Font.Draw ("Time Survived: ", 371, 190, font3, white)
Font.Draw (intstr(finaltime), 530, 190, font3, white)
delay (1000)
Font.Draw ("Rings Collected: ", 357, 130, font3, white)
Font.Draw (intstr(rings), 530, 130, font3, white)
delay (1000)
Font.Draw ("x 2", 590, 130, font3, white)
delay (500)
drawfillbox (529,129,589,150,black)
Font.Draw (intstr(rings * 2), 530, 130, font3, white)
delay (1000)
Draw.ThickLine (330, 100, 620, 100, 2, white)
Font.Draw ("Final Score: ", 357, 60, font3, white)
delay (1000)

fork PlaySound (tally)
for i : 0 .. score
    drawfillbox (529,59,620,80,black)
    Font.Draw (intstr(i), 530, 60, font3, white)
    drawfillbox (529,249,620,270,black)
    Font.Draw (intstr(score - i), 530, 250, font3, white)
    delay (1200 div (score+1))
end for
    
for i : 0 .. finaltime
    drawfillbox (529,59,620,80,black)
    Font.Draw (intstr(i + score), 530, 60, font3, white)
    drawfillbox (529,189,620,210,black)
    Font.Draw (intstr(finaltime - i), 530, 190, font3, white)
    delay (1200 div (finaltime+1))
end for
    
for i : 0 .. (rings * 2)
    drawfillbox (529,59,620,80,black)
    Font.Draw (intstr(i + score + finaltime), 530, 60, font3, white)
    drawfillbox (529,129,620,150,black)
    Font.Draw (intstr((rings*2) - i), 530, 130, font3, white)
    delay (1200 div (rings*2+1))
end for
    
open : f1, "highscore_data", read    
for i : 1 .. 8                    
    read : f1, highscores (i)
end for
    close :f1

setscreen ("nooffscreenonly")
Pic.ScreenLoad ("Pics/initials.bmp",350,342,picCopy)
Text.LocateXY (560,364)
get highscores (9).name :*
drawfillbox (350,342,639,389,black)
if length (highscores (9).name) > 3 then
    Pic.ScreenLoad ("Pics/invalid.bmp",550,351,picCopy)
    delay (500)
    drawfillbox (550,350,621,370,white)
    loop
        Text.LocateXY (560,364)
        get highscores (9).name :*
        if length (highscores (9).name) <= 3 then
            exit
        else
            Pic.ScreenLoad ("Pics/initials.bmp",350,342,picCopy)
            delay (500)
            drawfillbox (550,350,621,370,white)
        end if
    end loop
end if

highscores (9).score := (score + finaltime + rings*2)
sort

if highscores (9).score > highscores (8).score then  
    Sprite.Show (dancesprite)
    Sprite.SetPosition (dancesprite, 320, 13, false) 
    Sprite.Show (highscoresprite)
    Sprite.SetPosition (highscoresprite, 360, 13, false) 
    Music.PlayFileStop
    fork PlaySoundLoop (highscore_music)
end if
Pic.DrawSpecial (playagain, 0, 0, picCopy, picFadeIn, 500)
setscreen ("offscreenonly")
loop
    mousewhere (a,b,button)
    if button = 1 and a >= 70 and a <= 252 and b >= 116 and b <= 154 then
        open : f1, "highscore_data", write
        for i : 1 .. 8
            write : f1, highscores (i)
        end for
            close :f1
        delay (100)
        exit
    elsif button = 1 and a >= 112 and a <= 203 and b >= 26 and b <= 62 then
        open : f1, "highscore_data", write 
        for i : 1 .. 8
            write : f1, highscores (i)
        end for
            close :f1
        finished := true
        delay (100)
        exit
    elsif button = 1 and a >= 33 and a <= 293 and b >= 69 and b <= 109 then
        Sprite.Hide (dancesprite)
        Sprite.Hide (highscoresprite)
        drawscores
        loop
            mousewhere (a,b,button)
            if button = 1 and a >= 58 and a <= 128 and b >= 338 and b <= 379 then
                pagevisit := true                 
                finished := true
                exit
            elsif button = 1 and a >= 487 and a <= 610 and b >= 338 and b <= 379 then
                pagevisit := true
                exit
            end if
        end loop
    end if
    if pagevisit then
        exit
    end if
    scoretimer := Time.Elapsed
    Sprite.ChangePic (dancesprite, dancepic ((round (scoretimer) div 100) mod 7 + 1))
    Sprite.ChangePic (highscoresprite, highscorepic ((round (scoretimer) div 50) mod 7 + 1))
end loop
Sprite.Hide (dancesprite)
Sprite.Hide (highscoresprite)

