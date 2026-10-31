tag @s add this.selector

scoreboard players operation @s game.player.target_band = #gamestate gamestate.band_progression
scoreboard players add @s game.player.target_band 2
execute if score @s game.player.target_band > #segments segments.elapsed run scoreboard players operation @s game.player.target_band = #segments segments.elapsed

execute as @e[type=text_display,tag=band_display] if score @s segments.elapsed = @p[tag=this.selector] game.player.target_band at @s run summon marker ~ ~ ~ {"Tags":["skill.killer.trapper.random_marker"]}

execute as @n[type=marker,tag=skill.killer.trapper.random_marker] expand:
    spreadplayers ~ ~ 0 35 under 60 false @s
    execute at @s function ./spawn_trap
    kill @s

title @s actionbar {"translate": "skill.killer.trapper.full_inventory","color":"#9e3f3f","with":[{"color":"#866654","translate":"skill.killer.trapper.ability.name","italic":false,"with":[{"sprite":"minecraft:block/tripwire_hook","atlas":"minecraft:blocks","color":"white"}]}]}
playsound minecraft:item.bundle.insert_fail master @s ~ ~ ~ 1 1

tag @s remove this.selector