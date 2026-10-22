execute as @a run function render:tick/personal

# Animates the sidebar
function render:points/animate_sidebar
scoreboard players reset @a[tag=!game.playing] game.player.points # Remove spectators from sidebar