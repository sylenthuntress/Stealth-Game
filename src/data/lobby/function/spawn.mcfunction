import util:coordinates as coords
# Reset
scoreboard players set @s lobby.ready 1
gamemode adventure
effect clear @s
effect give @s weakness infinite 255 true
effect give @s resistance infinite 255 true
effect give @s saturation infinite 255 true

# Fill hotbar
function ./inventory/refresh_inventory

# Teleport
teleport coords.lobby.x coords.lobby.y coords.lobby.z