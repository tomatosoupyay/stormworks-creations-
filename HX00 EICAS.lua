--main eicas, collects faults and displays them to increase pilot awareness and reduce correction time.
S = screen
SC = S.setColor
DRF = S.drawRectF
DL = S.drawLine
DT = S.drawTriangle

--fault tables, warning, caution, other, info
wmsgs = {}
cmsgs = {}
omsgs = {}
imsgs = {}

--[[cycles
cycleTime = 23
displayTime = 21.5
lastCycleTime = 0
displayFirstSet = true
--]]
lengthofwarnings = 0
lengthofcautions = 0
function onTick()
    -- clear tables every tick, inefficient on run time but hey it works..
    wmsgs = {}
    cmsgs = {}
    omsgs = {}
    imsgs = {}

    -- removed local, its redudant as far as i can tell (in context of sw scripting)
    e1n2 = input.getNumber(1)
    e1t = input.getNumber(2)
    e1n1 = input.getNumber(3)
    e2n2 = input.getNumber(4)
    e2t = input.getNumber(5)
    e2n1 = input.getNumber(6)
    fuell = input.getNumber(7)
    fuelr = input.getNumber(8)
    fuelc = input.getNumber(9)
    fire1 = input.getBool(1)
    fire2 = input.getBool(2)
    blink = input.getBool(3)
    afire = input.getBool(4)
    afault = input.getBool(5)
    arun = input.getBool(6)
    poff = input.getBool(7)
    sby = input.getBool(8)
    blink2 = input.getBool(9)
    mldl = input.getBool(10)
    mrdl = input.getBool(11)
    ngdl = input.getBool(12)
    gf = input.getBool(13) --something you will never have
    e1genoff = input.getBool(14)
    e2genoff = input.getBool(15)
    adiruoff = input.getBool(16)
    stfualarm = input.getBool(17)
    forcedirlaw = input.getBool(18)
    fctllaw = input.getNumber(10)
    AFLOOR = input.getBool(19)
    temp = input.getNumber(11)
    agenoff = input.getBool(20) --
    flapdiff = input.getNumber(12)
    flappos = input.getNumber(13)
    throt = input.getNumber(14)
    gpsLissue = input.getBool(21)
    gpsRissue = input.getBool(22)
    ovspd = input.getBool(23)
    flapnoexist = input.getBool(24)
    RA = input.getNumber(15)
    RAT = input.getBool(25)
    doorbell = input.getBool(26)
    cabbaro = input.getNumber(16)
    rev = input.getBool(27)
    spoilersarm = input.getBool(28)
    selcal = input.getBool(29)
    --FDR=input.getBool(30)
    pbrake = input.getBool(31)
    --splrfault=input.getBool(32)
    cabready = input.getNumber(17)
    fmcstatus = input.getNumber(18)
    gpwsinhib = input.getNumber(19)
    fmcexist = input.getNumber(20)
    tcasstatus = input.getNumber(21)
    spoilerfault = input.getNumber(22)

    -- faults collection
    if fire1 then table.insert(wmsgs, "E1 FIRE") end
    if fire2 then table.insert(wmsgs, "E2 FIRE") end
    if e1n2 < 6 then table.insert(wmsgs, "E1 STALL") end
    if e2n2 < 6 then table.insert(wmsgs, "E2 STALL") end
    if afire then table.insert(wmsgs, "APU FIRE") end
    if math.abs(fuell - fuelr) > 500 then table.insert(cmsgs, "FUEL IMBAL") end
    if fuell < 500 or fuelr < 500 then table.insert(cmsgs, "FUEL LOW") end
    if poff then table.insert(cmsgs, "PUMP OFF") end
    if sby then table.insert(cmsgs, "STBY PWR") end
    if arun then table.insert(imsgs, "APU RUN") end
    if afault then table.insert(imsgs, "APU INOP") end
    if mldl and mrdl and ngdl then table.insert(imsgs, "GEAR DOWN") end
    if gf then table.insert(wmsgs, "GEAR WARN") end
    if e1genoff then table.insert(cmsgs, "E1 GEN OFF") end
    if e2genoff then table.insert(cmsgs, "E2 GEN OFF") end
    if adiruoff then table.insert(cmsgs, "ADIRU OFF") end
    if forcedirlaw or fctllaw == 2 then table.insert(wmsgs, "FCTL DIR L") end
    if fctllaw == 1 then table.insert(cmsgs, "FCTL ALT L") end
    if AFLOOR then table.insert(wmsgs, "A.FLOOR") end
    if temp > 60 and temp < 70 then table.insert(cmsgs, "CAB TEMP") end
    if temp > 70 then table.insert(wmsgs, "CAB FIRE") end
    if agenoff and arun then table.insert(cmsgs, "APU GEN") end
    if math.abs(flapdiff) > 0.03 then table.insert(wmsgs, "FLAP ASSY") end
    if gpsLissue then table.insert(cmsgs, "GPS L") end
    if gpsRissue then table.insert(cmsgs, "GPS R") end
    if gpsLissue and gpsRissue then table.insert(wmsgs, "GPS FAIL") end
    if ovspd then table.insert(cmsgs, "OVERSPEED") end
    if flapnoexist then table.insert(wmsgs, "FLAP FAIL") end
    if throt > 0.9 and RA < 2.5 and flappos < 1.6 or throt > 0.9 and RA < 2.5 and pbrake then table.insert(wmsgs,
            "TOFF CONF") end
    if RAT then table.insert(wmsgs, "RAT") end
    if doorbell then table.insert(imsgs, "Doorbell") end
    if cabbaro < 0.7 then table.insert(wmsgs, "CABIN ALT") end
    if rev then table.insert(imsgs, "REV") end
    if spoilersarm then table.insert(imsgs, "SPLRS ARM") end
    if selcal then table.insert(omsgs, "*SELCAL") end
    --if FDR then table.insert(wmsgs,"FDR-NOFLY") end
    if cabready == 1 then table.insert(omsgs, "CAB READY") end -- i had to switch to using numbers, for even bools because my bool channels have become saturated (ive used all 32 channels)
    if fmcstatus == 1 then table.insert(imsgs, "*FMC") elseif fmcstatus == 3 or fmcstatus == 0 then table.insert(wmsgs,"FMC FAULT") end
    if gpwsinhib == 1 then table.insert(cmsgs, "GPWS INHBT") end
    if tcasstatus <= 1 then table.insert(cmsgs, "TCAS FAIL") elseif tcasstatus == 2 then table.insert(cmsgs, "TCAS RA") elseif tcasstatus == 3 then table.insert(cmsgs, "TCAS OFF") elseif tcasstatus == 4 then table.insert(cmsgs, "TCAS TA") end
    --holy conditional ^
    if spoilerfault == 1 then table.insert(cmsgs, "SPLR FAIL") end
    if pbrake then table.insert(imsgs, "PBRAKE") end
    if RA < 60 then table.insert(imsgs,"YD OFF") end
    if blink2 then -- every 1.5 seconds cycles to second set. might add more sets soon or switch to a for-loop based system since thats way more efficient.
        displayFirstSet = false
    end
    --output.setNumber(1,lengthofwarnings) --dbg
    --output.setNumber(2,#wmsgs) --dbg

    if #wmsgs > lengthofwarnings and not stfualarm then output.setBool(1, true) else output.setBool(1, false) end -- sends a pulse if length of wmsgs changes, pretty simple
    if #cmsgs > lengthofcautions and not stfualarm then output.setBool(2, true) else output.setBool(2, false) end -- sends pulse if length of cmsgs changes crazy
    lengthofwarnings = #wmsgs
    lengthofcautions = #cmsgs
end

function onDraw()
    lineYPositions = { 36, 41, 46, 51, 56 }

    -- put faults into a single table
    allFaults = {}
    for _, fault in ipairs(wmsgs) do
        table.insert(allFaults, { text = fault, color = { 255, 0, 0 } }) -- Red for wmsgs (warning)
    end
    for _, fault in ipairs(cmsgs) do
        table.insert(allFaults, { text = fault, color = { 255, 93, 0 } }) -- Orange for cmsgs (caution)
    end
    for _, fault in ipairs(imsgs) do
        table.insert(allFaults, { text = fault, color = { 255, 0, 159 } }) -- Purple for imsgs (info)
    end
    for _, fault in ipairs(omsgs) do
        table.insert(allFaults, { text = fault, color = { 0, 255, 0 } }) -- Green for omsgs (other)
    end

    -- check if allFaults table is empty
    if #allFaults == 0 then
        return -- exit early if no faults to display
    end

    -- determine which set of faults to display
    displayedFaults = {}
    startIdx = 1

    if #allFaults > 5 then
        if blink2 then
            startIdx = displayFirstSet and 1 or 6
        end
    end

    -- collect faults to display
    for i = startIdx, #allFaults do
        table.insert(displayedFaults, allFaults[i])
        if #displayedFaults >= 5 then
            break -- Limit to 5 faults
        end
    end

    -- display faults
    i = 1
    for _, fault in ipairs(displayedFaults) do
        SC(fault.color[1], fault.color[2], fault.color[3])
        txt(25, lineYPositions[i], fault.text)
        i = i + 1
    end

    SC(255, 255, 255)
end

function txt(x, y, t)
    t = tostring(t)
    for i = 1, t:len() do
        local c = t:sub(i, i):upper():byte() * 3 - 95
        if c > 193 then
            c = c - 78
        end
        c = "0x" ..
        string.sub(
        "0000D0808F6F5FAB6D5B7080690096525272120222010168F9F5F1BBD9DBE2FDDBFBB8BCFBFEAF0A01A025055505289C69D7A7FB6699F96FB9FA869BF2F9F921EF69F11FCFF8F696FA4F9EFA55BB8F8F1FE1EF3FD2DC3CBFDF9086109F4841118406F90F09F6642",
        c, c + 2)
        for j = 0, 11 do
            if c & (1 << (11 - j)) > 0 then
                local b = x + j // 4 + i * 4 - 4
                DL(b, y + j % 4, b, y + j % 4 + 1)
            end
        end
    end
end
