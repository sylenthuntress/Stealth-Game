import util:coordinates as coords

execute positioned coords.lobby.x coords.lobby.y coords.lobby.z if entity @s[distance=300..,gamemode=!creative,gamemode=!spectator] run function lobby:spawn
