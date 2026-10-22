schedule function game:start 200t

scoreboard players set $gamestate gamestate.generating 0
execute as @a[tag=game.playing] expand:
    gamemode spectator 
    effect clear @s
    at @s run playsound minecraft:block.bell.use master @s ~ ~ ~ 1 1.5