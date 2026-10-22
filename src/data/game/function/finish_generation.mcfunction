schedule function game:start 200t

scoreboard players set $gamestate gamestate.generating 0
execute as @a[tag=game.viewing] expand:
    gamemode spectator 
    effect clear @s
playsound minecraft:block.bell.use master @a[tag=game.viewing] ~ ~ ~ 1 1.5 1
playsound minecraft:entity.elder_guardian.curse master @a[tag=game.viewing] ~ ~ ~ 0.5 1.48 0.5