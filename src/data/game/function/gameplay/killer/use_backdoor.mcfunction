advancement revoke @s only game:use_backdoor
effect give @s slow_falling 2 100 true

tag @s add this.selector
execute as @e[type=text_display,tag=band_display] if score @s segments.elapsed = @p[tag=this.selector] game.player.target_band at @s run tp @p[tag=this.selector] ~ ~ ~ 180 ~
tag @s remove this.selector

execute at @s run playsound minecraft:entity.player.teleport player @s ~ ~ ~ 1 1
execute as @a[tag=playing] at @s unless score @s game.player.team_id matches 2 run playsound minecraft:block.note_block.flute master @s ~ ~ ~ 0.3 1.5

function game:gameplay/killer/get_backdoor