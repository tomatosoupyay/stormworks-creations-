--This script simply prevents the aircraft from going beyond critical Angle Of Attack and hence stalling.
altlaw=false --alternate law
dirlaw=false --direct law
function onTick()
	altlaw=input.getBool(1)
	dirlaw=input.getBool(2)
	aoa=input.getNumber(2) -- angle of attack
	IAS=input.getNumber(3) -- indicated air speed
	RA=input.getNumber(4) -- radio altimeter (AGL)
	elevrequest=input.getNumber(1) -- requested elevator input from seat/autopilot
	if not altlaw and not dirlaw and IAS > 15 and math.abs(aoa)<0.45 and RA > 60 then -- verifies that alternate law and direct law are NOT active, IAS is greater than 30 knots, AOA is less than 0.45 and AGL is greater than 200ft.
		elev=1 --full nose down
		output.setBool(1,true) --full throttle up
	else
		elev=elevrequest --if the aircraft is not at critical aoa, elev requested is elev output and throttle up is false
		output.setBool(1,false)
	end
	
	output.setNumber(1,elev)
end
