--civic infotainment
--kikuri needs her alcohol
--bocchi happy!
S=screen
SC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF

radiofreq=0
keypadnums=0000
home=true
radio=false
car=false
map=false
cable=false
keyboard=false
tempFreq = radiofreq
digitCount = 0
prevPress = false
setcode=0
alarmact=false
alarmactconfirmed=false
ticks=0
function onTick()
    
    cableavail=input.getBool(32)
    press=input.getBool(1)
	inputX=input.getNumber(3)
	inputY=input.getNumber(4)
    clk=math.floor(input.getNumber(23))
    code=input.getNumber(24)
    gpsx=input.getNumber(21)
    gpsy=input.getNumber(22)
    if code ~= setcode then ticks=ticks+1 else ticks=0 end
    if ticks < 600 then
        if ipir(inputX, inputY, 1,12,63,4) and press and car then
            setcode = code
        end
    end
    if ipir(inputX,inputY,1,7,34,4) and press and alarmactconfirmed == false then
        output.setBool(1,true)
        output.setBool(2,false)
    elseif ipir(inputX,inputY,1,7,34,4) and press and alarmactconfirmed == true then
        output.setBool(2,true)
        output.setBool(1,false)
    else
        output.setBool(1,false)
        output.setBool(2,false)
    end
	output.setBool(30,radio)
	output.setBool(31,cable)
    output.setNumber(1,radiofreq)
    output.setNumber(2,setcode) --valid code
    alarmactconfirmed=input.getBool(20)
end

function onDraw()

if home then
SC(104,104,104)
DR(2,16,22,7)
DR(39,7,22,7)
DR(2,7,22,7)
DR(39,16,22,7)
SC(185,185,185)
txt(4,9,"audio")
txt(4,18,"cable")
txt(45,9,"MAP")
txt(2,0,"BACK")
txt(45,18,"CAR")
if not cableavail then
SC(255,0,0)
DL(2,16,24.25,23.25)
end
end



--radio
if press and ipir(inputX,inputY,2,7,23,8) and home then
radio=true
home=false
end
if radio then

SC(0,13,23)
DR(39,7,24,24)
SC(185,185,185)
txt(6,7,"karakara")
txt(8,12,"kessoku")
txt(13,17,"band")
DL(1,24,4.25,27.25)
DL(1,30,4.25,27.25)
txt(6,25,"ch.")
SC(0,56,99)
txt(18,25,radiofreq)
if ipir(inputX,inputY,0,24,5,7) and press then
keyboard=true
end
if ipir(inputX,inputY,31,24,5,7) and press then
keyboard=false
end
if keyboard then
SC(25,25,25,150)
DRF(0,6.5,64,26)
SC(170,170,170)
DR(1,7,29,24)
SC(108,108,108)
DRF(2,8.5,28,23)
SC(11,11,11)
DRF(3,9.5,26,6)
DRF(7,16.5,17,14)
SC(185,185,185)
txt(8,10,radiofreq)
txt(8,16,"1234")
txt(8,21,"5678")
txt(8,26,"9")
txt(20,26,"0")
DL(35,24,32.25,27.25)
DL(32,27,35.25,30.25)
--time for death
if press and not prevPress then
    if ipir(inputX, inputY, 8, 16, 3, 4) then
        handleNumpadInput(1)
    elseif ipir(inputX, inputY, 12, 16, 3, 4) then
        handleNumpadInput(2)
    elseif ipir(inputX, inputY, 16, 16, 3, 4) then
        handleNumpadInput(3)
    elseif ipir(inputX, inputY, 20, 16, 3, 4) then
        handleNumpadInput(4)
    elseif ipir(inputX, inputY, 8, 21, 3, 4) then
        handleNumpadInput(5)
    elseif ipir(inputX, inputY, 12, 21, 3, 4) then
        handleNumpadInput(6)
    elseif ipir(inputX, inputY, 16, 21, 3, 4) then
        handleNumpadInput(7)
    elseif ipir(inputX, inputY, 20, 21, 3, 4) then
        handleNumpadInput(8)
    elseif ipir(inputX, inputY, 8, 26, 3, 4) then
        handleNumpadInput(9)
    elseif ipir(inputX, inputY, 20, 26, 3, 4) then
        handleNumpadInput(0)
    end
end
-- update prevPress state (makes the buttons pulse not push)
prevPress = press

end
end
--radio ends

if ipir(inputX,inputY,39,7,23,8) and press and home then
map=true
home=false
end
if map then
screen.setMapColorOcean(0,72,255)
screen.setMapColorShallows(0,72,255)
screen.setMapColorLand(115,155,115)
screen.setMapColorGrass(255,255,255)
screen.setMapColorSand(240,240,240)
screen.setMapColorSnow(255,255,255)
screen.setMapColorRock(84,84,84)
screen.setMapColorGravel(115,115,115)
screen.drawMap(gpsx,gpsy,2)
end

if ipir(inputX,inputY,39,16,23,8) and press and home then
car=true
home=false
end
if car then 
SC(185,185,185)
if ticks < 600 then 
txt(1,12,"chg code (press)")
else
txt(1,12,"chg code locked")
end
txt(1,27,"soup")
txt(1,7,"ALARM:")
txt(1,18,"VER: 2.2")

if alarmactconfirmed then
SC(0,255,0)
txt(24,7,"yes") --or no!
else
SC(255,0,0)
txt(24,7,"NO")
end
end



if ipir(inputX,inputY,2,16,23,8) and press and cableavail and not cable and home then
cable=true
home=false
end
if ipir(inputX,inputY,58,0,6,5) and press and cable then
cable=false
home=true
end

if ipir (inputX,inputY,0,0,19,5) and press then --back
home=true
radio=false
car=false
map=false
cable=false
keyboard=false
end
if not cable then
SC(0,0,0)
DRF(0,0.5,64,6)
SC(179,179,179)
txt(49,0,clk)
SC(0,56,99)
DL(0,5,63.25,5.25)
SC(185,185,185)
txt(2,0,"BACK")
end
if cable then
SC(255,0,0)
txt(59,0,"x")
end
if not cableavail and cable then
cable=false
home=true
end
end

function ipir(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end
function handleNumpadInput(num)
    if digitCount >= 4 then
        tempFreq = 0
        digitCount = 0
    end
    tempFreq = tempFreq * 10 + num
    digitCount = digitCount + 1
    radiofreq = tempFreq
end


function txt(x,y,t)t=tostring(t)for i=1,t:len()do local c=t:sub(i,i):upper():byte()*3-95if c>193then c=c-78 end c="0x"..string.sub("0000D0808F6F5FAB6D5B7080690096525272120222010168F9F5F1BBD9DBE2FDDBFBB8BCFBFEAF0A01A025055505289C69D7A7FB6699F96FB9FA869BF2F9F921EF69F11FCFF8F696FA4F9EFA55BB8F8F1FE1EF3FD2DC3CBFDF9086109F4841118406F90F09F6642",c,c+2)for j=0,11 do if c&(1<<(11-j))>0then local b=x+j//4+i*4-4 DL(b,y+j%4,b,y+j%4+1)end end end end
