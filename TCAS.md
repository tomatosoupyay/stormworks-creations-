I decided to create a new TCAS standard. The script is still work in progress, but will be effectively universal across aircraft, since its up to you to make your own interfaces. I did this since most other TCAS systems have a set interface that isnt particularly realistic.


# Inputs
#### Received from other aircraft, radio
1. X-coordinate
2. Y-coordinate
3. Altitude
4. Squawk Code
5. Signal Strength
6. Tail Number (ASCII)
7. Aircraft Type (Received aircraft data, as ASCII) (EX: 72504848 FOR H200)
* #### Your own aircraft, to be transmitted later
8. Own X-coordinate (From your GPS/navi system)
9.Own Y-coordinate (From your GPS/navi system)
10. Own Altitude (From your altimeter)
11. Own Squawk Code
# Output Channels (Radio transmission and external system outputs)
#### Radio Output Channels (Your aircraft data, transmitted to other aircraft
CH1 (bool) Transmit flag
1. X-coordinate (Own position)
2. Y-coordinate (Own position)
3. Altitude (Own position)
4. Squawk Code (Own aircraft)
5. Tail Number (Own, as ASCII)
6. Aircraft Type (Own, as ASCII)
7. Useless
8. Useless
#### External Detected Aircraft Data Output Channels (Processed data for external systems)
9. X-coordinate (Detected aircraft)
10. Y-coordinate (Detected aircraft)
11. Altitude (Detected aircraft)
12. Squawk Code (Detected aircraft)
13. Tail Number (Detected aircraft, as ASCII)
14. Aircraft Type (Detected aircraft, as ASCII)
15. Signal Strength (Detected aircraft)
16. Table Index (Cycling index for detected aircraft)



this is unfinished and subject to change blah blah
