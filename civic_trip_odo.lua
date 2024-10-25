--look at this redundant code!! woah!!
--holt town
--karakara is fire
--bbbbbocchi
-- <3
S=screen
SC=S.setColor
DRF=S.drawRectF
DL=S.drawLine
DC=S.drawCircle
DTX=S.drawText
fuelstart=0 --fuel at engine started
fuelnow=0 -- fuel at engine stop (right now)
estart=false -- is the engine started?
aspeed=0 -- average speed
distance=0 -- distance total
elapsed=0 -- time elapsed since engine start
units=false -- iirc false is mph and kmh is true? so real
ticks=0 --tick counts
capacitor=false --screen on capacitor (stays on for 10 seconds after keyoff)
odo=0 --odometer
finalodo=0 --odometer reading thats final idk
speed=0 --speed now
temp=0 -- engine temp
fuelused=0
mpg=0
speedms=0 --speed in m/s
epulse=false
function onTick()
	ticks=ticks+1
    fuelnow=input.getNumber(8)
    fuelstart=input.getNumber(11) -- start of trip fuel idk (pretty sure this already pulses reset on start idk)
    -- a reminder that fuelstart is taken from a memory register outside the script
    estart=input.getBool(15) -- engine start bool thing
    units=input.getBool(10)
    capacitor=input.getBool(16)
    epulse=input.getBool(17) -- i decided to use a pulse outside the script since i forgot how to make one in lua and i cant use my phone right now
    speed=input.getNumber(1)
    temp=input.getNumber(7)
    park=input.getBool(1)
    speedms=input.getNumber(13)
    if estart then elapsed = elapsed+1 elseif not capacitor or epulse then elapsed=0 end --one liner is crazy
	if ticks <= 61 then ticks=0 end
    if speedms > 0.5 and estart == true then
        odo = odo + ((speedms)/60)
        finalodo=odo/1000 --km
    end
    if capacitor==false or epulse then odo=0 finalodo=0 end
    fuelused=fuelstart-fuelnow
    mpg=((finalodo/1.609344) / ((fuelstart - fuelnow)/3.785))
    
    aspeed=(finalodo * 0.621371) / (elapsed / 216000)
    --output.setNumber(1,aspeed)
    --output.setNumber(2,elapsed)
end

function onDraw()
    SC(120,0,0)
    DRF(83,28.5-(fuelnow/5.2),9,13) --fuel
    DRF(4,28.5-(temp/9.5),8,13) --temp
    SC(1,1,1)
    DRF(9,26.5,3,2)
    DRF(83,26.5,4,2)
    DRF(83,17.5,1,3)
    DRF(92,0.5,4,28)
    DRF(12,15.5,71,13)
    DRF(11,18.5,1,4)
    DRF(88,17.5,4,2)
    DRF(87,15.5,5,2)
    DRF(89,19.5,3,2)
    DRF(83,20.5,2,3)
    DRF(91,24.5,1,2)
    DRF(83,23.5,3,3)
    DRF(90,21.5,2,3)
    DRF(10,22.5,2,6)
    DRF(4,15.5,3,5)
    DRF(4,23.5,1,3)
    DRF(4,20.5,2,3)
    DRF(0,0.5,4,28)
    DRF(4,15.5,4,2)
    DRF(0,28.5,96,4)
    DRF(0,0.5,96,15)
    DL(9,4,24.25,31.25)
    DL(8,4,23.25,31.25)
    DL(10,4,25.25,31.25)
    SC(7,7,7)
    DL(86,4,71.25,31.25)
    SC(1,1,1)
    DL(70,31,85.25,4.25)
    DL(87,4,72.25,31.25)
    SC(36,36,36)
    DC(48,23,16)
    SC(69,69,69)
    DC(48,23,17)
    DRF(63,29.5,1,1)
    DRF(33,29.5,1,1)
    DRF(33,17.5,1,1)
    DRF(42,8.5,1,1)
    DRF(54,8.5,1,1)
    DRF(63,17.5,1,1)
    SC(38,38,38)
    txt(28,24,"0")
    txt(28,17,"1")
    txt(30,11,"2")
    txt(34,6,"3")
    txt(38,4,"4")
    txt(42,2,"5")
    txt(47,2,"6")
    txt(52,2,"7")
    txt(56,4,"8")
    txt(60,7,"9")
    txt(66,23,"12")
    txt(64,11,"10")
    txt(66,17,"11")
    SC(255,255,255)
    DL(8,15,4.25,27.25)
    DL(86,15,91.25,27.25)
    SC(52,52,52)
    DL(83,15,87.25,27.25)
    DL(11,15,8.25,27.25)
    SC(255,236,0)
    DRF(3,28.5,2,4)
    DRF(2,29.5,4,3)
    DRF(2,30.5,1,1)
    DRF(1,30.5,1,1)
    DRF(0,28.5,1,4)
    DRF(6,30.5,1,2)
    SC(7,7,7)
    DL(19,3,11.25,4.25)
    DL(76,3,84.25,4.25)
    SC(16,255,0)
    DC(89,10,2)
    DL(93,8,95.25,8.25)
    DL(93,10,95.25,10.25)
    DL(93,12,95.25,12.25)
    if park then
    SC(255,0,0)
    DTX(24,10,"p")
    end
    SC(255,255,255)
    txt(39,12,"trip:")
    if not units then
    txt(35,17,string.format("%.1f mpg", mpg))
    txt(43,22,math.ceil(aspeed))
    else
    txt(35,17,string.format("%.1f L1K", mpg*235.21))
    txt(43,22,math.ceil(aspeed*1.609))
    end
    txt(35,27,"avg spd")
    SC(255,0,0)
    DC(74,11,2)
    DRF(74,5.5,1,5)
    DRF(73,5.5,1,1)
    DRF(73,7.5,1,1)
    SC(255,255,255)
    txt(3,15,"H")
    txt(89,15,"F")
end

function txt(x,y,t)t=tostring(t)for i=1,t:len()do local c=t:sub(i,i):upper():byte()*3-95if c>193then c=c-78 end c="0x"..string.sub("0000D0808F6F5FAB6D5B7080690096525272120222010168F9F5F1BBD9DBE2FDDBFBB8BCFBFEAF0A01A025055505289C69D7A7FB6699F96FB9FA869BF2F9F921EF69F11FCFF8F696FA4F9EFA55BB8F8F1FE1EF3FD2DC3CBFDF9086109F4841118406F90F09F6642",c,c+2)for j=0,11 do if c&(1<<(11-j))>0then local b=x+j//4+i*4-4 DL(b,y+j%4,b,y+j%4+1)end end end end
