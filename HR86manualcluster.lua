S=screen
SC=S.setColor
DRF=S.drawRectF
DCF=S.drawCircleF
DC=S.drawCircle
DL=S.drawLine
DR=S.drawRect
temphi=false
templo=false
master=false
lap=0
best=0
lastcount=0
ib=input.getBool
ino=input.getNumber

function drawArc(x,y,r,a,b,p,s)
a=a or 0; b=b or 360; if b<a then a,b=b,a end; s=s or 22.5
local c,d,q=math.cos,math.sin,0.0174533
local t=a; local u,v
repeat
local w=(a-90)*q
local i,j=x+r*c(w),y+r*d(w)
if a~=t then
if p then screen.drawTriangleF(x,y,u,v,i,j) else screen.drawLine(u,v,i,j) end
end
u,v=i,j
a=math.min(a+s,b)
until a>=b
end --tajin


function onTick()
park=ib(1)
rps=ino(1)
spdms=ino(2)
temp=ino(3)
n=ib(2)
batt=ib(3)
seat=ib(4)
key=ib(5)
fuel=ino(4)
check=ib(6)
slip=ib(7)
dbsfault=ib(8)
left=ib(12)
right=ib(13)
oat=ino(5)
clk=math.floor(ino(6))
hstate=ino(7)
drawnodo=ino(8)
gear=ino(9)
blink=ib(14)
pulselap=ib(15)
track=ib(16)
pulsebest=ib(17)
count=ino(10)
battlvl=ino(11)
unit=ib(18)
cc=ib(19)
ls=ino(12)
rng=ino(13)
sf=ib(20)
spf=ib(21)
dtc=ino(16)
x=ino(17)
y=ino(18)
map=ib(22)
ab=ib(23)
abw=ib(24)
abo=ib(25)
ah=ib(26)
master=dbsfault or sf and blink or((rps<1 and hstate>=1)or key or batt or trk or spf)and seat
temphi=temp>100
templo=temp<30


if count<lastcount then count=lastcount end
	lap=count
	if pulselap then
		if best==0 or lap<best then best=lap end
		lapstart = count
	end
	-- rst
	if pulsebest then
		best = 0
		lapstart = count 
	end
end


function onDraw()

if map then
S.drawMap(x + 232, y + 15, 0.7)
SC(255,255,255)
DRF(16,17.5,1,1)
end
SC(3,3,3)
DRF(69,19.5,17,3)
DRF(67,0.5,20,7)
SC(72,72,72)
DRF(53+(fuel*0.5),19.5,17,3)
SC(3,3,3)
DRF(68,23.5,28,9)
DRF(29,10.5,39,22)
DRF(5,25.5,24,7)
DRF(5,0.5,63,10)
DRF(0,0.5,5,32)
DRF(68,13.5,19,6)
DRF(87,13.5,9,10)
DRF(68,8.5,28,5)
DRF(87,0.5,9,7)
if not track then
SC(2,2,2)
DCF(47,16,12.2)
SC(115,115,115)
drawArc(47,17,12,-180,(rps*11.49 - 180),true,10)
end
SC(72,72,72)
DRF(45,4.5,5,1)
DRF(50,5.5,2,1)
DRF(52,6.5,2,1)
DRF(54,7.5,42,1)
DRF(43,5.5,2,1)
DRF(41,6.5,2,1)
DRF(0,7.5,41,1)
DRF(45,29.5,5,1)
DRF(50,28.5,2,1)
DRF(52,27.5,2,1)
DRF(54,26.5,42,1)
DRF(43,28.5,2,1)
DRF(41,27.5,2,1)
DRF(0,26.5,41,1)
if not track then
SC(2,2,2)
DCF(47,17,9.2)
SC(255,255,255)
DC(47,17,9)
SC(72,72,72)
DL(37,10,39.25,8.25)
DL(37,23,39.25,25.25)
DRF(34,15.5,1,5)
DRF(35,19.5,1,2)
DRF(36,21.5,1,2)
DRF(35,13.5,1,2)
DRF(36,11.5,1,2)
DRF(58,11.5,1,2)
DRF(59,13.5,1,2)
DRF(60,15.5,1,5)
DRF(59,20.5,1,2)
DRF(58,22.5,1,2)
DL(55,8,57.25,10.25)
DL(55,25,57.25,23.25)
DRF(39,17.5,1,1)
DRF(47,9.5,1,1)
SC(255,0,0)
DRF(55,17.5,1,1)
end
SC(255,255,255)
DRF(68,13.5,1,4)
DRF(68,16.5,19,1)
DRF(86,13.5,1,4)
DRF(68,19.5,1,4)
DRF(68,22.5,19,1)
DRF(86,19.5,1,4)
txt(59,8,math.ceil(oat) .. "C")
txt(76, 8, (function(s) return s:sub(1,2)..":"..s:sub(3,4) end)(string.format("%04d", clk))) --chatgpt
SC(255,255,255)
txt(64,13,"c")
txt(88,13,"h")
txt(64,19,"e")
txt(88,19,"f")
if park then
SC(255,0,0)
txt(46,0,"P")
end
if hstate==3 or ah then
SC(12,0,255)
DRF(32,1.5,2,1)
DRF(32,3.5,2,1)
DCF(29,2,1.2)
end
SC(0,255,0)
if left then txt(41,0,"<") end
if right then txt(50,0,">") end
if slip or dbsfault then
SC(255,209,0)
DRF(54,0.5,7,7)
SC(4,4,4)
DR(56,0,2,2)
DRF(56,2.5,3,2)
DL(55,6,56.25,5.25)
DL(57,6,58.25,5.25)
end
SC(72,72,72)
DL(72,0,60.25,7.25)
DL(22,0,34.25,7.25)
if hstate == 1 or hstate == 2 then
SC(0,255,0)
DC(36,5,1)
DL(39,4,40.25,4.25)
DL(39,6,40.25,6.25)
end
if master then
SC(255,209,0)
DRF(76,0.5,1,1)
DRF(74,3.5,5,2)
DRF(73,5.5,7,1)
DRF(75,1.5,3,2)
SC(4,4,4)
txt(75,2,"!")
end
if seat then
SC(255,0,0,254)
DCF(83,2,1.2)
DRF(83,5.5,2,1)
DL(85,4,87.25,2.25)
end
if batt then
SC(124,255,0)
DR(2,29,4,2)
SC(41,84,0)
DRF(2,27.5,1,3)
DRF(1,28.5,3,1)
DRF(5,28.5,3,1)
end
SC(124,255,0)
if check or dtc ~= 0 then
DRF(12,29.5,3,3)
DRF(11,30.5,1,1)
DRF(10,28.5,1,4)
DRF(13,28.5,2,1)
DRF(15,29.5,1,3)
DRF(16,30.5,1,2)
end
SC(255,0,0)
if dbsfault then txt(32,28,"DBS") end
if key then
DC(57,29,2)
DRF(61,28.5,1,1)
DRF(63,28.5,1,1)
DRF(60,29.5,4,1)
end
SC(124,255,0)
if abo then txt(19,28,"aeb") end
if fuel < 7 then
DR(91,21,2,2)
DRF(91,23.5,3,2)
DL(94,22,94.25,22.25)
DL(95,21,95.25,21.25)
end
if temphi then SC(255,0,0) else SC(0,0,255) end
if temphi or templo then
DRF(93,13.5,1,4)
DRF(94,13.5,1,1)
DRF(94,15.5,1,1)
DL(91,18,92.25,19.25)
DL(93,18,94.25,19.25)
DL(95,18,96.25,19.25)
end
SC(255,255,255)
if not track then
txt(42,12, math.floor(spdms * (unit and 3.6 or 2.29)))
txt(42,17, unit and "kmh" or "mph")
SC(255,255,255)
if not map then
SC(3,3,3)
DRF(5,10.5,24,15)
SC(255,255,255)
local mpg=(ls>0 and spdms>0)and(2.35215*spdms/(ls*1000))or 0
txt(2,11,string.format("%.1f",math.min(unit and mpg*.42514 or mpg,99.9)))
txt(18,11,unit and "K/L" or "mpg")

txt(2,18,math.floor(rng))
txt(18,18,"km")
end
else
SC(255,255,255)
txt(36,22, math.floor(spdms * (unit and 3.6 or 2.29)))
txt(48,22, unit and "kmh" or "mph")
end
DRF(77,15.5,1,2)
DRF(77,21.5,1,2)
DRF(82,21.5,1,2)
DRF(72,21.5,1,2)
SC(72,72,72)
DRF(69+(temp*0.14),13.5,1,3)
SC(255,255,255)
txt(0, 2, string.format("%04d",math.floor((unit and drawnodo or drawnodo / 1.609) % 10000)))
txt(17,2, unit and "km" or "mi")
if not track then
SC(255,0,0,120)
DRF(57,15.5,3,3)
SC(255,255,0,120)
DRF(56,13.5,3,2)
end
if not track then
if rps > 22.7 and blink then SC(255,0,0) elseif rps > 22 and blink then SC(135,135,0) else SC(2,2,2) end
DRF(44,22.5,7,4)
if gear <= -1 then
SC(97,0,0)
txt(46,22,"R")
elseif gear >=1 then
SC(72,72,72)
txt(46,22,math.floor(gear))
else
SC(0,255,0)
txt(46,22,"N")
end
else
if rps > 22.7 and blink then SC(255,0,0) elseif rps > 22 and blink then SC(135,135,0) else SC(2,2,2) end
DRF(44,7.5,7,4)
if gear <= -1 then
SC(97,0,0)
txt(46,7,"R")
elseif gear >=1 then
SC(72,72,72)
txt(46,7,math.floor(gear))
else
SC(0,255,0)
txt(46,7,"N")
end
end
--track stuff
if track then
SC(3,3,3)
DRF(5,10.5,24,15)
SC(255,255,255)
txt(5,10,math.floor(temp) .. "C")
DRF(23,12.5,3,1)
DRF(24,13.5,3,1)
DRF(27,12.5,1,1)
DRF(24,10.5,2,1)
bm, bs = math.floor(best/3600), math.floor(best/60)%60
bh = math.floor((best%60)*10/60)
cm, cs = math.floor(count/3600), math.floor(count/60)%60
ch = math.floor((count%60)*10/60)
-- best
txt(5,16,string.format("%02d",bm))
txt(12,17,":")
txt(15,16,string.format("%02d",bs))
txt(22,16,".")
txt(25,16,string.format("%01d",bh))
-- current
txt(5,21,string.format("%02d",cm))
txt(12,22,":")
txt(15,21,string.format("%02d",cs))
txt(22,21,".")
txt(25,21,string.format("%01d",ch))

SC(255,255,255)
DRF(36,20.5,23,1)
DL(58,11,37.25,15.25)
DRF(36,11.5,1+(rps*0.88),9)
SC(3,3,3)
DRF(36,11.5,4,4)
DRF(39,11.5,6,3)
DRF(44,11.5,7,2)
DRF(51,11.5,5,1)
SC(255,0,0,120)
DRF(56,12.5,3,8)
SC(255,255,0,120)
DRF(54,13.5,2,7)
SC(72,72,72)
DRF(39,16.5,1,4)
DRF(42,15.5,1,5)
DRF(45,14.5,1,6)
DRF(48,14.5,1,6)
DRF(51,13.5,1,7)
end
if dbsfault or key or sf or abb or abw then
SC(3,3,3)
DRF(5,10.5,24,15)
SC(255,255,255)
DR(5,10,23,14)
if key then
SC(255,255,255)
txt(7,12,"ENTER")
txt(9,18,"CODE")
end
if dbsfault then
SC(3,3,3)
DRF(5,10.5,24,15)
SC(255,0,0)
txt(7,12,"BRAKE")
txt(7,18,"FAIL!")
end
if sf then
SC(3,3,3)
DRF(5,10.5,24,15)
SC(255,0,0)
txt(6,11,"steer")
txt(6,16,"fail")
SC(255,124,0)
DC(23,20,2)
DRF(22,20.5,3,1)
DRF(23,20.5,1,2)
txt(26,18,"!")
end
SC(255,0,0)
if abw and not ab then 
txt(10,12,"obs.")
txt(7,18,"ahead")
end
if ab then
txt(8,16,"stop!")
end
end
if cc then 
SC(4,255,0)
DC(68,29,2)
DL(70,28,71.25,27.25)
txt(73,28,"SET")
end
if sf or spf then 
SC(255,124,0)
DRF(90,4.5,3,1)
DRF(91,4.5,1,2)
DC(91,4,2.1)
if sf then
txt(94,2,"!")
SC(201,0,0,150)
DL(87,6,95.25,1.25)
end
end
if hstate == 2 and not abo and rps > 7.2 and spdms > 3.5 and spdms < 84 and not batt then 
SC(0,255,0)
DC(86,29,2)
DRF(91,27.5,3,1)
DRF(91,29.5,3,1)
DRF(91,31.5,3,1)
SC(12,0,255)
DRF(85,29.5,1,2)
DRF(86,28.5,1,2)
DRF(87,29.5,1,2)
end
end


function txt(x,y,t)t=tostring(t)for i=1,t:len()do local c=t:sub(i,i):upper():byte()*3-95if c>193then c=c-78 end c="0x"..string.sub("0000D0808F6F5FAB6D5B7080690096525272120222010168F9F5F1BBD9DBE2FDDBFBB8BCFBFEAF0A01A025055505289C69D7A7FB6699F96FB9FA869BF2F9F921EF69F11FCFF8F696FA4F9EFA55BB8F8F1FE1EF3FD2DC3CBFDF9086109F4841118406F90F09F6642",c,c+2)for j=0,11 do if c&(1<<(11-j))>0then local b=x+j//4+i*4-4 DL(b,y+j%4,b,y+j%4+1)end end end end
