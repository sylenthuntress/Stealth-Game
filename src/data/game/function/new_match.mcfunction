import util:coordinates as coords

# Remove lobby tag
tag @a[tag=playing] remove lobby

# Start map generation
teleport @a[tag=playing] coords.loading.x coords.loading.y coords.loading.z
effect give @a[tag=playing] blindness infinite 255 true
effect give @a[tag=playing] invisibility infinite 255 true
schedule function level:start_gen 10t

# Schedule match start
schedule function game:start 100t