--[[
i made this at school, i dont remember the proper channels to use or have any way to test it, nor do i remember how to make odometers, so this is a very simple prototype!
i plan for all these variables to reset say, 20 seconds after key off or when engine is restarted,
giving you time to read the output. this screen will also serve as a "insert code to start" reminder
this will all be on a video switchbox that switches from the main screen to this. 
i will draw the gauges in the background, and maybe a few dashlights (battery and check eng?), but not speed, the rpm digits will NOT show
not gonna draw anything right now because i dont remember the positions of all the items

--]]

fuelstart=0 --fuel at engine started
fuelend=0 -- fuel at engine stop
estart=false -- is the engine started?
aspeed=0 -- average speed
distance=0 -- distance total
elapsed=0 -- time elapsed since engine start
speed=0 -- current speed (m/s)
units=false -- iirc false is mph and kmh is true? so real
speeds={} -- collects speed every second ig
ticks=0
function onTick()
	ticks=ticks+1
    fuelstart=input.getNumber(1) -- start of trip fuel idk
    estart=input.getBool(1) -- engine start bool thing
    elapsed=input.getNumber(2) -- will probably just be a counter
    speed=input.getNumber(3)
    units=input.getBool(2)
    if estart == false then
        fuelstart=fuelend
	end
	if ticks < 61 then ticks=0 end
	if ticks == 60 then
		table.insert(speeds,speed)
	end
end

function onDraw()
--[[
a basic idea of what i want is this:
txt(36,13,"this trip:")
txt(44,18,"xx MPG")
txt(32,23,"xxx mph avg")
txt(36,28,"1234 (mi)")
--]]
screen.setColor(0,0,255)
screen.drawRectF(0,0.5,96,32)
screen.setColor(255,255,255)
screen.drawText(15,6,"NOT COMPLETE")
screen.drawText(13,15,"haha!!!!")
screen.drawText(10,24,":(")
end



