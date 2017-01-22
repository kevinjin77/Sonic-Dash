%Kevin Jin Summative
%http://compsci.ca/v3/viewtopic.php?t=34475
%http://randomhoohaas.flyingomelette.com/Sprites/spr-sonic.php
%http://www.spriters-resource.com/custom_edited/sonic/
%http://sonic.wikia.com/wiki/Item_Box
% None of the characters or pictures belong to me!

var program : int
program := Window.Open ("graphics:639;400")
setscreen ("offscreenonly")


type highscore :
record
    name : string (11)
    score : int
end record

var font1, font2 : int
font1 := Font.New ("Small Fonts:14")
font2 := Font.New ("Small Fonts:10")

var page1ID, page2ID, page3ID, page4ID, threeID, twoID, oneID, goID, segaID, blackID, highscoreID : int
page1ID := Pic.FileNew ("Pics/instructions1.bmp")
page2ID := Pic.FileNew ("Pics/instructions2.bmp")
page3ID := Pic.FileNew ("Pics/instructions3.bmp")
page4ID := Pic.FileNew ("Pics/instructions4.bmp")
segaID := Pic.FileNew ("Pics/segasprite.bmp")
blackID := Pic.FileNew ("Pics/black.bmp")
highscoreID := Pic.FileNew ("Pics/highscoreback.bmp")

var a,b,button : int := 0
var titlex : int := 0
var titletimer : real := 0
var minustime : real := 0

var titlepic : array 1 .. 8 of int
for i : 1 .. 8
    titlepic(i) := Pic.FileNew ("Pics/titlesprite"+intstr(i)+".bmp")
end for
    
var startpic, instructionspic : array 1 .. 2 of int 
for i : 1 .. 2
    startpic(i) := Pic.FileNew ("Pics/startsprite"+intstr(i)+".bmp")
    instructionspic(i) := Pic.FileNew ("Pics/instructionssprite"+intstr(i)+".bmp")
end for
    
var titlesprite : int := Sprite.New (titlepic(1))
var startsprite : int
startsprite := Sprite.New (startpic(2))
var instructionssprite : int
instructionssprite := Sprite.New (instructionspic(2))

var rules : boolean := false
var page : int := 0

var highscores : array 1 .. 11 of highscore %declaring array of new type.
var f1 : int % this loop sends array data to data

var chars : array char of boolean
var charsLast : array char of boolean

process PlaySound (file : string)
    Music.PlayFile(file)
end PlaySound

process PlaySoundLoop (file : string)
    Music.PlayFileLoop (file)
end PlaySoundLoop

proc titlescreen
    page := 0
    Sprite.Show (titlesprite)
    Sprite.Show (startsprite)
    Sprite.Show (instructionssprite)
    Sprite.SetPosition (titlesprite, 155, 165, false) 
    Sprite.SetPosition (startsprite, 195, 110, false) 
    Sprite.SetPosition (instructionssprite, 184, 40, false) 
    loop
	mousewhere (a,b,button)
	if button = 1 and a >= 196 and a <= 445 and b >= 111 and b <= 158 then
	    exit
	elsif button = 1 and a >= 188 and a <= 453 and b >= 44 and b <= 91 then
	    rules := true
	    page := 1
	    exit
	end if
	titletimer := Time.Elapsed
	
	titlex -= 1
	if titlex < -1277 then
	    titlex := 0
	end if
	Pic.ScreenLoad ("Pics/titlescreen.bmp",titlex,0,picCopy)
	if titletimer <= 1140 then
	    Sprite.ChangePic (titlesprite, titlepic ((round (titletimer) div 200) mod 6 + 2))
	else
	    Sprite.ChangePic (titlesprite, titlepic ((round (titletimer) div 300) mod 2 + 7))
	end if
	Sprite.ChangePic (startsprite, startpic ((round (titletimer) div 500) mod 2 + 1))
	Sprite.ChangePic (instructionssprite, instructionspic ((round (titletimer+500) div 500) mod 2 + 1))
	View.Update
	delay (1)
	cls
    end loop
    cls
    Sprite.Hide (titlesprite)
    Sprite.Hide (startsprite)
    Sprite.Hide (instructionssprite)
end titlescreen

proc page1
    Pic.DrawSpecial (page1ID, 0, 0, picCopy, picFadeIn, 500)
    loop
	mousewhere (a,b,button)
	if button = 1 and a >= 12 and a <= 150 and b >= 339 and b <= 374 then
	    rules := false
	    page -= 1
	    exit
	elsif button = 1 and a >= 516 and a <= 625 and b >= 339 and b <= 374 then
	    page += 1
	    exit
	end if
    end loop
end page1

proc page2
    Pic.DrawSpecial (page2ID, 0, 0, picCopy, picFadeIn, 500)
    loop
	mousewhere (a,b,button)
	if button = 1 and a >= 12 and a <= 150 and b >= 339 and b <= 374 then
	    page -= 1
	    exit
	elsif button = 1 and a >= 516 and a <= 625 and b >= 339 and b <= 374 then
	    page += 1
	    exit
	end if
    end loop
end page2

proc page3
    Pic.DrawSpecial (page3ID, 0, 0, picCopy, picFadeIn, 500)
    loop
	mousewhere (a,b,button)
	if button = 1 and a >= 12 and a <= 150 and b >= 339 and b <= 374 then
	    page -= 1
	    exit
	elsif button = 1 and a >= 516 and a <= 625 and b >= 339 and b <= 374 then
	    page += 1
	    exit
	end if
    end loop
end page3

proc page4
    Pic.DrawSpecial (page4ID, 0, 0, picCopy, picFadeIn, 500)
    loop
	mousewhere (a,b,button)
	if button = 1 and a >= 12 and a <= 150 and b >= 339 and b <= 374 then
	    page -= 1
	    exit
	elsif button = 1 and a >= 516 and a <= 625 and b >= 339 and b <= 374 then
	    page += 1
	    exit
	end if
    end loop
end page4

proc drawscores
    cls
    setscreen ("nooffscreenonly")
    Pic.DrawSpecial (highscoreID,0,0,picCopy,picFadeIn,500)
    setscreen ("offscreenonly")
    for i : 1 .. 8                     % this loop places data from array
	%put highscores (i).name, "  " ..  % into the screen
	%put highscores (i).score, "  " 
	Font.Draw (highscores (i).name,275,320-(i*35),font1,black)
	Font.Draw (intstr(highscores (i).score),475,320-(i*35),font1,black)
    end for
	for i : 1 .. 8
	Font.Draw (intstr(i),95,320-(i*35),font1,black)
    end for
	open : f1, "highscore_data", write        % this loop gets data from data file
    for i : 1 .. 8                     % and places it into the array
	write : f1, highscores (i)
    end for
	close :f1
end drawscores

proc sort
    for decreasing i : 8 .. 1
	if highscores (9).score > highscores (i).score and highscores (9).score <= highscores (i-1).score then 
	    for decreasing q : 8 .. i 
		highscores (q).score := highscores (q-1).score 
		highscores (q).name := highscores (q-1).name 
	    end for 
		highscores (i).score := highscores (9).score
	    highscores (i).name := highscores (9).name
	    exit
	elsif highscores (9).score > highscores (1).score and i = 2 then 
	    for decreasing q : 8 .. i 
		highscores (q).score := highscores (q-1).score 
		highscores (q).name := highscores (q-1).name 
	    end for 
		highscores (1).score := highscores (9).score 
	    highscores (1).name := highscores (9).name
	    exit
	end if
    end for
end sort

function KeyPushedDown (c : char) : boolean 
    result not charsLast (c) and chars (c) 
end KeyPushedDown

function KeyReleased (c : char) : boolean 
    result charsLast (c) and not chars (c) 
end KeyReleased

const sega : string := "Music/sega.mp3"
const titlemusic : string := "Music/titlescreen_music.mp3"
const gamemusic : string := "Music/game_music.mp3"
const ring_sound : string := "Music/ring.wav" 
const shield_sound : string := "Music/shield.wav" 
const life_sound : string := "Music/life.wav" 
const rings_sound : string := "Music/rings.wav" 
const shoes_music : string := "Music/shoes_music.mp3" 
const countdown : string := "Music/countdown.mp3" 
const gameover : string := "Music/gameover.mp3" 
const tally : string := "Music/tally.wav"  
const highscore_music : string := "Music/highscore.mp3" 
const gamemusic1 : string := "Music/game_music1.mp3"
const tooslow : string := "Music/tooslow.wav" 

var gravity:real:=2
var vely:real:=0
var jump_speed:real:=8

var timer : real := 0
var backtimer : real := 0
var shoestimer : real := 0
var crabtimer : real := 0
var finaltime : int := 0

var lifepic : array 0 .. 9 of int
for i : 0 .. 9
    lifepic(i) := Pic.FileNew ("Pics/lifebar"+intstr(i)+".bmp")
end for
    
var shieldedpic : array 0 .. 3 of int
for i : 0 .. 3
    shieldedpic(i) := Pic.FileNew ("Pics/shielded"+intstr(i)+".bmp")
end for
    
var rollpic : array 1 .. 10 of int
for i : 1 .. 8
    rollpic(i) := Pic.FileNew ("Pics/rollsprite"+intstr(i)+".bmp")
end for
    
var runpic : array 1 .. 9 of int
for i : 1 .. 9
    runpic(i) := Pic.FileNew ("Pics/runsprite"+intstr(i)+".bmp")
end for
    
var shieldpic : array 1 .. 8 of int
for i : 1 .. 8
    shieldpic(i) := Pic.FileNew ("Pics/shield"+intstr(i)+".bmp")
end for
    
var ringpic : array 1 .. 9 of int
for i : 1 .. 9
    ringpic(i) := Pic.FileNew ("Pics/ring"+intstr(i)+".bmp")
end for
    
var crabpic : array 1 .. 9 of int
for i : 1 .. 9
    crabpic(i) := Pic.FileNew ("Pics/crab"+intstr(i)+".bmp")
end for
    
var batpic : array 1 .. 6 of int
for i : 1 .. 6
    batpic(i) := Pic.FileNew ("Pics/bat"+intstr(i)+".bmp")
end for
    
var bunnypic : array 1 .. 7 of int
for i : 1 .. 7
    bunnypic(i) := Pic.FileNew ("Pics/bunny"+intstr(i)+".bmp")
end for
    
var lancerpic : array 1 .. 14 of int
for i : 1 .. 14
    lancerpic(i) := Pic.FileNew ("Pics/lancer"+intstr(i)+".bmp")
end for
    
var ghostpic : array 1 .. 12 of int
for i : 1 .. 12
    ghostpic(i) := Pic.FileNew ("Pics/ghost"+intstr(i)+".bmp")
end for
    
var eggmanpic : array 1 .. 3 of int
for i : 1 .. 3
    eggmanpic(i) := Pic.FileNew ("Pics/eggman"+intstr(i)+".bmp")
end for
    
var jumpsprite3:=Pic.FileNew ("Pics/jumpsprite3.bmp")
var jumpsprite5:=Pic.FileNew ("Pics/jumpsprite5.bmp")
var fallsprite := Pic.FileNew ("Pics/fallsprite.bmp")

var shieldpowerupsprite := Sprite.New (Pic.FileNew ("Pics/shieldpowerup.bmp"))
var shoespowerupsprite := Sprite.New (Pic.FileNew ("Pics/shoespowerup.bmp"))
var lifepowerupsprite := Sprite.New (Pic.FileNew ("Pics/lifepowerup.bmp"))
var ringspowerupsprite := Sprite.New (Pic.FileNew ("Pics/ringspowerup.bmp"))
var ringicon := Sprite.New (Pic.FileNew ("Pics/ringicon.bmp"))
var shoesicon := Sprite.New (Pic.FileNew ("Pics/floatshoes.bmp"))

var eggmanbat := Sprite.New (Pic.FileNew ("Pics/eggmanbat.bmp"))
var eggmanlancer := Sprite.New (Pic.FileNew ("Pics/eggmanlancer.bmp"))
var eggmanbunny := Sprite.New (Pic.FileNew ("Pics/eggmanbunny.bmp"))
var eggmanghost := Sprite.New (Pic.FileNew ("Pics/eggmanghost.bmp"))

var threesprite : int := Sprite.New (Pic.FileNew ("Pics/3.bmp"))
var twosprite : int := Sprite.New (Pic.FileNew ("Pics/2.bmp"))
var onesprite : int := Sprite.New (Pic.FileNew ("Pics/1.bmp"))
var gosprite : int := Sprite.New (Pic.FileNew ("Pics/go.bmp"))
Sprite.SetPosition (threesprite,0,0,false)
Sprite.SetPosition (twosprite,0,0,false)
Sprite.SetPosition (onesprite,0,0,false)
Sprite.SetPosition (gosprite,0,0,false)

%------------------------------------------SONIC + ENEMIES SPRITES------------------------------------------%
var sonic : int 
sonic := Sprite.New (rollpic(1))
var lifebar : int
lifebar := Sprite.New (lifepic(9))
var shielded : int
shielded := Sprite.New (shieldedpic(0))
var shieldsprite : int 
shieldsprite := Sprite.New (shieldpic(1))
var ringsprite : int 
ringsprite := Sprite.New (ringpic(1))
var crabsprite : int 
crabsprite := Sprite.New (crabpic(1))
var batsprite : int 
batsprite := Sprite.New (batpic(1))
var bunnysprite : int 
bunnysprite := Sprite.New (bunnypic(1))
var lancersprite : int 
lancersprite := Sprite.New (lancerpic(1))
var ghostsprite : int 
ghostsprite := Sprite.New (ghostpic(1))
var eggman : int 
eggman := Sprite.New (eggmanpic(1))

setscreen ("nooffscreenonly")
fork PlaySound (sega)
Pic.DrawSpecial (segaID, 0, 0, picCopy, picFadeIn, 2000)
Pic.DrawSpecial (blackID, 0, 0, picCopy, picFadeIn, 1000)
setscreen ("offscreenonly")

loop
    var x : int := 100
    var y : int := 12
    var backgroundx : int := 0
    var speed : real := 350
    var lives : real := 9
    var score : int := 0
    var rings : int := 0
    var startJump, endJump : real := 0
    var onground : boolean := true
    var rolling : boolean := false
    var doubledjumped : boolean := false
    var collided : boolean := false
    var finished, pagevisit : boolean := false
    
    var ringx, shieldx, shoesx, lifex, ringsx, crabx, batx, bunnyx, lancerx, ghostx : int := 0
    var ringcollide, shieldcollide, shoescollide, lifecollide, ringscollide, crabcollide, batcollide, bunnycollide, lancercollide, ghostcollide := false
    var ringy := 17
    var shieldy := 12
    var shoesy := 12
    var lifey := 12
    var ringsy := 12
    var craby : int := 12
    var baty := 42
    var bunnyy := 12
    var lancery := 12
    var ghosty := 12
    var bunnyvely :real :=0
    var bunnygravup :real := 1
    var bunnygravdown :real := 2
    var bunnyup : boolean := true
    include "titlescreen.t"
    
    var shield : int := 0
    var shoes : boolean := false
    
    var frame : int := 1
    Sprite.SetPosition (sonic, x, y, false) 
    Sprite.Show (sonic)
    Sprite.SetPosition (lifebar, 5, 320, false) 
    Sprite.Show (lifebar)
    Sprite.SetPosition (ringicon, 377, 360, false) 
    Sprite.Show (ringicon)
    Sprite.SetPosition (shielded, 182, 345, false) 
    Sprite.Show (shielded)
    Sprite.SetPosition (shoesicon, 570, 365, false) 
    
    %setscreen ("nooffscreenonly")
    Time.DelaySinceLast (500)
    fork PlaySound (countdown)
    Sprite.Show (threesprite)
    Time.DelaySinceLast (1000)
    Sprite.Hide (threesprite)
    Sprite.Show (twosprite)
    Time.DelaySinceLast (1000)
    Sprite.Hide (twosprite)
    Sprite.Show (onesprite)
    Time.DelaySinceLast (1000)
    Sprite.Hide (onesprite)
    Sprite.Show (gosprite)
    Time.DelaySinceLast (900)
    Sprite.Hide (gosprite)
    cls
    minustime := Time.Elapsed / 1000
    %setscreen ("offscreenonly")
    
    Input.KeyDown(chars) 
    Input.KeyDown(charsLast) 
    fork PlaySoundLoop (gamemusic)
    loop 
	if shoes then
	    gravity := 0.1
	else 
	    gravity := 0.2
	end if
	timer := (Time.Elapsed / 1000) - minustime
	backtimer := ((Time.Elapsed / 1000) - minustime) mod (985.8 * (speed ** -0.9974))
	if timer - shoestimer >= 20 then
	    shoes := false
	end if
	charsLast := chars
	Input.KeyDown (chars)
	locate (1,1)
	Sprite.SetPosition(sonic, x, y, false)
	Sprite.SetPosition(shieldsprite, x, y, false)
	if shield > 0 then
	    Sprite.Show(shieldsprite)
	    if not rolling then
		Sprite.Animate (shieldsprite, shieldpic (((439 - round(timer*200)) div 5) mod 8 + 1), x+8, y+6, false)
	    elsif rolling then
		Sprite.Animate (shieldsprite, shieldpic (((439 - round(timer*200)) div 5) mod 8 + 1), x, y, false)
	    end if
	else
	    Sprite.Hide (shieldsprite)
	end if
	speed += 0.01
	%speed := (1.8 * timer) + 350
	%put backtimer
	%put backgroundx - round(backtimer*350)
	drawfillbox (0,350,maxx,maxy,53)
	Font.Draw ("Score: " + intstr(score), 267, 380, font1, black)
	Font.Draw ("Time: " + (realstr (timer, 4)), 267, 356, font1, black)
	Font.Draw (intstr(rings), 407, 368, font1, black)
	if shoes then
	    Sprite.Show (shoesicon)
	    drawfillbox (maxx - 70, 346, maxx, 456, black)
	    Font.Draw (realstr (20 - (timer - shoestimer), 4), 600, 368, font2, white)
	else
	    Sprite.Hide (shoesicon)
	end if
	Sprite.ChangePic (lifebar, lifepic (floor(lives)))
	Sprite.ChangePic (shielded, shieldedpic (shield))
	Pic.ScreenLoad ("Pics/background.bmp",backgroundx - round(backtimer*speed),0,picCopy)
	if backgroundx - round(backtimer*speed) <= -1000 then
	    %put "THIS ", backtimer
	    %delay (1000)
	    backgroundx := 0
	end if
	if vely>0 then 
	    Sprite.ChangePic(sonic, jumpsprite3)
	elsif vely<0 then
	    Sprite.ChangePic(sonic, jumpsprite5)  
	elsif chars (KEY_DOWN_ARROW) then
	    rolling := true
	    %backgroundx -=10  
	    if frame < 4 then
		frame += 1
	    else
		frame := 1
	    end if
	    Sprite.ChangePic (sonic, rollpic(frame))
	    %Time.DelaySinceLast(10)
	elsif KeyReleased (KEY_DOWN_ARROW) then
	    rolling := false
	elsif chars ('b') then
	    score += 1
	elsif chars ('n') then
	    lives := 0
	elsif speed >= 42000 then
	    fork PlaySoundLoop (gamemusic1)
	else
	    %backgroundx -= 1
	    
	    if frame < 9 then
		frame += 1
	    else
		frame := 1
	    end if
	    Sprite.ChangePic (sonic, runpic(frame))
	    %Time.DelaySinceLast(10)
	end if
	if KeyPushedDown (' ') then
	    fork PlaySound (tooslow)
	end if
	if KeyPushedDown(KEY_UP_ARROW) and onground then
	    startJump := timer  
	    %vely := jump_speed
	end if
	
	if chars (KEY_DOWN_ARROW) and not onground then
	    Sprite.ChangePic(sonic, rollpic(1))
	    gravity := 1
	end if
	
	if KeyReleased (KEY_UP_ARROW) and (onground or not doubledjumped) then
	    if vely not= 0 then
		doubledjumped:=true
	    end if
	    endJump := timer
	    jump_speed := 5.374 * (endJump - startJump) + 5.613
	    if not chars (KEY_DOWN_ARROW) then
		if jump_speed > 8.3 then
		    jump_speed := 8.3
		elsif jump_speed < 6 then
		    jump_speed := 6           
		end if
	    end if
	    vely := jump_speed    
	end if  
	
	if y<=12 then
	    onground:=true
	    doubledjumped:=false
	else
	    onground:=false
	end if
	
	y+=round(vely)
	vely-=gravity
	
	if y<=12 then
	    vely:=0
	    y:=12
	end if
	
	%---------------------------------------------------RING------------------------------------------------%
	Sprite.SetPosition (ringsprite, maxx+10, 12, false) 
	if not ringcollide then
	    Sprite.Show (ringsprite)
	else
	    Sprite.Hide (ringsprite)
	end if 
	%ringx := (639 - round(timer*600)) mod 639
	ringx -= 3
	if ringx<-24  and Rand.Int(1, 100) > 99 then
	    ringx:=maxx+24
	    ringy := Rand.Int (42, 300)
	end if
	Sprite.Animate (ringsprite, ringpic (((439 - round(timer*200)) div 5) mod 4 + 1), ringx, ringy, false)
	if ringx >= 629 then
	    ringcollide := false
	end if
	
	%---------------------------------------------------SHIELD------------------------------------------------%
	Sprite.SetPosition (shieldpowerupsprite, maxx+10, 12, false) 
	if not shieldcollide then
	    Sprite.Show (shieldpowerupsprite)
	else
	    Sprite.Hide (shieldpowerupsprite)
	end if 
	shieldx -= 3
	if shieldx<-30 and Rand.Int(1, 5000) > 4999 then
	    shieldx:=maxx+30
	    shieldy := Rand.Int (12, 300)
	end if
	Sprite.SetPosition (shieldpowerupsprite, shieldx, shieldy, false)
	if shieldx >= 629 then
	    shieldcollide := false
	end if
	
	%---------------------------------------------------SHOES------------------------------------------------%
	Sprite.SetPosition (shoespowerupsprite, maxx+10, 12, false) 
	if not shoescollide then
	    Sprite.Show (shoespowerupsprite)
	else
	    Sprite.Hide (shoespowerupsprite)
	end if 
	shoesx -= 3
	if shoesx<-30 and Rand.Int(1, 8000) > 7999 and timer > 30 then
	    shoesx:=maxx+30
	    shoesy := Rand.Int (12, 300)
	end if
	Sprite.SetPosition (shoespowerupsprite, shoesx, shoesy, false)
	if shoesx >= 629 then
	    shoescollide := false
	end if
	
	%---------------------------------------------------LIFE------------------------------------------------%
	Sprite.SetPosition (lifepowerupsprite, maxx+10, 12, false) 
	if not lifecollide then
	    Sprite.Show (lifepowerupsprite)
	else
	    Sprite.Hide (lifepowerupsprite)
	end if 
	lifex -= 3
	if lifex<-30 and Rand.Int(1, 5000) > 4999 and timer > 30 then
	    lifex:=maxx+30
	    lifey := Rand.Int (12, 300)
	end if
	Sprite.SetPosition (lifepowerupsprite, lifex, lifey, false)
	if lifex >= 629 then
	    lifecollide := false
	end if
	
	%---------------------------------------------------RINGS------------------------------------------------%
	Sprite.SetPosition (ringspowerupsprite, maxx+10, 12, false) 
	if not ringscollide then
	    Sprite.Show (ringspowerupsprite)
	else
	    Sprite.Hide (ringspowerupsprite)
	end if 
	ringsx -= 3
	if ringsx<-30 and Rand.Int(1, 5000) > 4999 then
	    ringsx:=maxx+30
	    ringsy := Rand.Int (12, 300)
	end if
	Sprite.SetPosition (ringspowerupsprite, ringsx, ringsy, false)
	if ringsx >= 629 then
	    ringscollide := false
	end if
	
	%---------------------------------------------------BAT------------------------------------------------% 
	Sprite.SetPosition (batsprite, maxx+10, 12, false) 
	if not batcollide then
	    Sprite.Show (batsprite)
	else
	    Sprite.Hide (batsprite)
	end if
	%batx := (639 - round(timer*500)) mod 639
	batx -= 3 + (round (timer) div 60)
	
	if batx<-50 and Rand.Int(1, 400) > 350 and timer > 15 then
	    batx:=maxx+50
	    baty := Rand.Int (42, 200)
	    score += 1
	end if
	
	Sprite.Animate (batsprite, batpic (((439 - round(timer*200)) div 10) mod 6 + 1), batx, baty, false)
	if batx >= 629 then
	    batcollide := false
	end if
	
	%---------------------------------------------------CRAB------------------------------------------------%
	Sprite.SetPosition (crabsprite, maxx+10, 12, false) 
	if not crabcollide then
	    Sprite.Show (crabsprite)
	else
	    Sprite.Hide (crabsprite)
	end if
	
	Sprite.Animate (crabsprite, crabpic (((439 - round(timer*100)) div 10) mod 8 + 1), crabx, craby, false)
	if crabx >= 629 then
	    crabcollide := false
	end if
	
	crabx -= 2 + (round (timer) div 60)
	
	if crabx<-48 and Rand.Int(1, 100)>98 then
	    crabx:=maxx+48
	    score += 1
	end if
	
	%---------------------------------------------------BUNNY------------------------------------------------%  
	Sprite.SetPosition (bunnysprite, maxx+10, 12, false) 
	if not bunnycollide then
	    Sprite.Show (bunnysprite)
	else
	    Sprite.Hide (bunnysprite)
	end if
	%bunnyx := (639 - round(timer*300)) mod 639
	bunnyx -= Rand.Int (1,3) + (round (timer) div 60)
	
	if bunnyx < - 45 and Rand.Int(1, 1000) > 999 and timer > 45  then
	    bunnyx := maxx + 45
	    score += 1
	end if
	
	if bunnyy>=200 then
	    bunnyup:=false
	elsif bunnyy<=12 then
	    bunnyup:=true
	end if
	
	if bunnyup then
	    bunnyvely+=bunnygravup
	else
	    bunnyvely-=bunnygravdown
	end if  
	
	bunnyy:=round(bunnyvely)
	
	Sprite.Animate (bunnysprite, bunnypic (((439 - round(timer*100)) div 10) mod 7 + 1), bunnyx, bunnyy, false)
	if bunnyx >= 529 then
	    bunnycollide := false
	end if
	
	%---------------------------------------------------LANCER------------------------------------------------%
	
	Sprite.SetPosition (lancersprite, maxx+10, 12, false) 
	if not lancercollide then
	    Sprite.Show (lancersprite)
	else
	    Sprite.Hide (lancersprite)
	end if
	%batx := (639 - round(timer*500)) mod 639
	if lancerx < 300 then
	    lancerx -= 5 + (round (timer) div 60)
	    Sprite.Animate (lancersprite, lancerpic (9), lancerx, lancery, false)
	else
	    lancerx -= 1
	    Sprite.Animate (lancersprite, lancerpic (((439 - round(timer*200)) div 10) mod 6 + 1), lancerx, lancery, false)
	end if
	if lancerx<-77 and Rand.Int(1, 500) > 499  and timer > 30 then
	    lancerx:=maxx+77
	    score += 1
	end if
	
	
	if lancerx >= 629 then
	    lancercollide := false
	end if
	
	%---------------------------------------------------GHOST------------------------------------------------% 
	Sprite.SetPosition (ghostsprite, maxx+10, 12, false) 
	if not ghostcollide then
	    Sprite.Show (ghostsprite)
	else
	    Sprite.Hide (ghostsprite)
	end if
	%ghostx := (639 - round(timer*500)) mod 639
	ghostx -= 2 + (round (timer) div 60)
	if ghostx < 500 then
	    Sprite.Hide (ghostsprite)
	end if
	if ghostx < 150 and not ghostcollide then
	    Sprite.Show (ghostsprite)
	end if
	
	if ghostx<-57 and Rand.Int(1, 1500) > 1499 and timer > 100 then
	    ghostx:=maxx+57
	    ghosty := Rand.Int (42, 200)
	    score += 1
	end if
	
	Sprite.Animate (ghostsprite, ghostpic (((439 - round(timer*200)) div 10) mod 6 + 1), ghostx, ghosty, false)
	if ghostx >= 629 then
	    ghostcollide := false
	end if
	%--------------------------------------------------COLLISION------------------------------------------------%  
	if not rolling then
	    if x+38 > ringx and x < ringx+24 and y+57 > ringy and y < ringy+24 then
		if not collided then
		    collided := true
		    ringcollide := true
		    fork PlaySound (ring_sound)
		    rings += 1
		    lives += 0.25
		    if lives > 9 then
			lives := 9
		    end if
		end if
	    elsif x+38 > shieldx and x < shieldx+30 and y+57 > shieldy and y < shieldy+30 then
		if not collided then
		    collided := true
		    shieldcollide := true
		    fork PlaySound (shield_sound)
		    shield := 3
		end if
	    elsif x+38 > shoesx and x < shoesx+30 and y+57 > shoesy and y < shoesy+30 then
		if not collided then
		    collided := true
		    shoescollide := true
		    shoes := true
		    shoestimer := timer
		    fork PlaySound (shoes_music)
		end if
	    elsif x+38 > lifex and x < lifex+30 and y+57 > lifey and y < lifey+30 then
		if not collided then
		    collided := true
		    lifecollide := true
		    fork PlaySound (life_sound)
		    lives += 2
		    if lives > 9 then
			lives := 9
		    end if
		end if
	    elsif x+38 > ringsx and x < ringsx+30 and y+57 > ringsy and y < ringsy+30 then
		if not collided then
		    collided := true
		    ringscollide := true
		    fork PlaySound (rings_sound)
		    rings += Rand.Int (3, 6)
		end if
	    elsif x+38 > crabx and x < crabx+48 and y+57 > craby and y < craby+58 then
		if not collided then
		    collided := true
		    crabcollide := true
		    if shield > 0 then
			shield -= 1
		    else
			lives -= 1
		    end if
		end if
	    elsif x+38 > batx+4 and x < batx+40 and y+57 > baty and y < baty+37 then
		if not collided then
		    collided := true
		    batcollide := true
		    if shield > 0 then
			shield -= 1
		    else
			lives -= 1
		    end if
		end if
	    elsif x+38 > bunnyx and x < bunnyx+40 and y+57 > bunnyy and y < bunnyy+58 then
		if not collided then
		    collided := true
		    bunnycollide := true
		    if shield > 0 then
			shield -= 1
		    else
			lives -= 1
		    end if
		end if
	    elsif x+38 > lancerx and x < lancerx+77 and y+57 > lancery and y < lancery+43 then
		if not collided then
		    collided := true
		    lancercollide := true
		    if shield > 0 then
			shield -= 1
		    else
			lives -= 1
		    end if
		end if  
	    elsif x+38 > ghostx+4 and x < ghostx+50 and y+57 > ghosty + 6 and y < ghosty+53 then
		if not collided then
		    collided := true
		    ghostcollide := true
		    if shield > 0 then
			shield -= 1
		    else
			lives -= 1
		    end if
		end if
	    else
		collided := false
	    end if
	elsif rolling then
	    if x+30 > ringx and x < ringx+24 and y+30 > ringy and y < ringy+24 then
		if not collided then
		    collided := true
		    ringcollide := true
		    fork PlaySound (ring_sound)
		    rings += 1
		    if lives < 9 then
			lives += 0.25
		    end if
		end if
	    elsif x+30 > shieldx and x < shieldx+30 and y+50 > shieldy and y < shieldy+30 then
		if not collided then
		    collided := true
		    shieldcollide := true
		    fork PlaySound (shield_sound)
		    shield := 3
		end if
	    elsif x+30 > shoesx and x < shoesx+30 and y+30 > shoesy and y < shoesy+30 then
		if not collided then
		    collided := true
		    shoescollide := true
		    shoes := true
		    shoestimer := timer
		    fork PlaySound (shoes_music)
		end if
	    elsif x+30 > lifex and x < lifex+30 and y+30 > lifey and y < lifey+30 then
		if not collided then
		    collided := true
		    lifecollide := true
		    fork PlaySound (life_sound)
		    lives += 2
		    if lives > 9 then
			lives := 9
		    end if
		end if
	    elsif x+30 > ringsx and x < ringsx+30 and y+30 > ringsy and y < ringsy+30 then
		if not collided then
		    collided := true
		    ringscollide := true
		    fork PlaySound (rings_sound)
		    rings += Rand.Int (3, 6)
		end if
	    elsif x+30 > crabx and x < crabx+48 and y+30 > craby and y < craby + 58 then
		if not collided then
		    collided := true
		    crabcollide := true
		    if shield > 0 then
			shield -= 1
		    else
			lives -= 1
		    end if
		end if
	    elsif x+30 > bunnyx+4 and x < bunnyx+40 and y+30 > bunnyy and y < bunnyy+58 then
		if not collided then
		    collided := true
		    bunnycollide := true
		    if shield > 0 then
			shield -= 1
		    else
			lives -= 1
		    end if
		end if
		%elsif x+30 > lancerx and x < lancerx+77 and y+50 > lancery and y < lancery+43 then
		%if not collided then
		%collided := true
		%lancercollide := true
		%end if
	    else
		collided := false
	    end if
	end if
	
	if timer >= 13 and timer <= 17 then
	    Sprite.SetPosition (eggman, 350, 105, false)
	    Sprite.Show (eggman)
	    Sprite.SetPosition (eggmanbat, 420, 200, false)
	    Sprite.Show (eggmanbat)
	    Sprite.ChangePic (eggman, eggmanpic(round (timer) mod 3 + 1))
	elsif timer >= 28 and timer <= 32 then
	    Sprite.SetPosition (eggman, 350, 105, false)
	    Sprite.Show (eggman)
	    Sprite.SetPosition (eggmanlancer, 420, 200, false)
	    Sprite.Show (eggmanlancer)
	    Sprite.ChangePic (eggman, eggmanpic(round (timer) mod 3 + 1))
	elsif timer >= 43 and timer <= 47 then
	    Sprite.SetPosition (eggman, 350, 105, false)
	    Sprite.Show (eggman)
	    Sprite.SetPosition (eggmanbunny, 420, 200, false)
	    Sprite.Show (eggmanbunny)
	    Sprite.ChangePic (eggman, eggmanpic(round (timer) mod 3 + 1))
	elsif timer >= 98 and timer <= 102 then
	    Sprite.SetPosition (eggman, 350, 105, false)
	    Sprite.Show (eggman)
	    Sprite.SetPosition (eggmanghost, 420, 200, false)
	    Sprite.Show (eggmanghost)
	    Sprite.ChangePic (eggman, eggmanpic(round (timer) mod 3 + 1))
	else
	    Sprite.Hide (eggman)
	    Sprite.Hide (eggmanbat)
	    Sprite.Hide (eggmanlancer)
	    Sprite.Hide (eggmanbunny)
	    Sprite.Hide (eggmanghost)
	end if
	if lives < 1 then
	    finaltime := round(timer)
	    Music.PlayFileStop
	    Sprite.ChangePic (lifebar, lifepic (0))
	    exit
	end if
	View.Update
	Time.DelaySinceLast(5)
    end loop
    
    include "scorescreen.t"
    exit when finished
end loop
Music.PlayFileStop
Window.Close (program)

