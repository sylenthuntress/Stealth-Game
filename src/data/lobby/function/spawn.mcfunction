import util:coordinates as coords
# Reset
effect clear @s
effect give @s resistance infinite 255 true
effect give @s saturation infinite 255 true

# Teleport
teleport coords.lobby.x coords.lobby.y coords.lobby.z