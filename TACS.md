--[[
hi guys, this is just the TACS standard. Its designed to take the usefullness of the unippu and EHCS standards and combine them, for ease of use. enjoyyy. Not final!


CHANNELS FOR TACS (TOMATO ATTACHMENT and COMPATIBILITY STANDARD)

ASCII is used for character transmission. see ASCII table: https://www.geeksforgeeks.org/ascii-table/
You can use channels 6-12 for your own needs, however, try not to use these too much, it would be preffered if you can make a suggestion to add to the standard.
NUMBER CHANNELS (from missile) 
 
17 G LIMIT
18 G LIMIT WITH MASTER ARM
19 RADIO FROM MISSILE (0 is N/A)
20 COUNT OR FUEL LEVEL (FOR RACKS AND EXT FUEL)
21 TYPE
23 LETTER 1
24 LETTER 2
25 LETTER 3
26 LETTER 4
27 LETTER 5
28 LETTER 6
29 LETTER 7
30 LETTER 8
31 LETTER 9
32 LETTER 10

BOOLS (to plane)
18 LOCKED

NUMBER CHANNELS (from plane)
18 RADIO FREQ TO MISSILE (SARH OR LASER)
19 X
20 Y
21 Z (Altitude)

BOOL CHANNELS (from plane)
18 FIRE (for multi ejector racks)
19 ARMED
20 SAVE COORDS OR LAZE CODE (for gps or laser guided stuff)




MAIN TYPES and SUBTYPES (to plane)
Channel 21, numbers 1-5 respectively

LAUNCHABLE (like a missile, or bomb)
AIR-AIR [1]
AIR-AIR SARH [2]
AIR-GRD RDR [3]
AIR-GRD SARH [4]
AIR-GRD LASER [5]
AIR-GRD GPS [6]
TORPEDO [7]
GPS BOMB [8]
LASER BOMB [9]
OTHER BOMB [10]
OTHER MISSILE [11]
--END OF LAUNCHABLES

FIRE TYPE (like a gunpod)
OTHER [12]
GUNPOD [13]
ROCKET POD [14] 
CHAFF [15]
FLARE [16]
--END OF FIRE TYPES

MULTIPLE WEAPON RACK (use channel 20 to indicate count)
AIR-AIR [17]
AIR-AIR SARH [18]
AIR-GRD RDR [19]
AIR-GRD SARH [20]
AIR-GRD LASER [21]
AIR-GRD GPS [22]
TORPEDO [23]
GPS BOMB [24]
LASER BOMB [25]
OTHER BOMB [26]
OTHER MISSILE [27]
--END OF RACKS

ACTIVATE TYPE (like a jamming pod or whatever)
OTHER [28]
JAMMING POD [29]
TARGETING POD [30]
--END OF ACTIVATE TYPES

NON WEAPONRY (like ext fuel tank)
OTHER [31]
FUEL [32]
--END
--]]
