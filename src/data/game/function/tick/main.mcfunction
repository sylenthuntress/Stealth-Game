# Tick subtasks
execute if score $gamestate gamestate.game_active matches 1 run function game:gameplay/tick/main
function render:tick/main

# Manage spectators
execute as @a[gamemode=spectator] at @s if entity @a[gamemode=!spectator,tag=playing] unless entity @a[gamemode=!spectator,distance=..32] run function game:leash_spectator:
    spectate @p[gamemode=!spectator]
    title @s actionbar {"translate": "game.spectator.too_far", "color": "red"}
    playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 2 0.7