import util:coordinates as coords

teleport coords.lobby.x coords.lobby.y coords.lobby.z

effect clear @s
effect give @s resistance infinite 255 true

team join lobby
team join dev @s[name=SylentHuntress]