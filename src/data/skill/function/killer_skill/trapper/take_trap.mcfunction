tag @s add this.self
execute at @s anchored eyes facing entity @n[tag=skill.killer.trapper.trap] feet positioned ^ ^ ^4 run kill @e[tag=skill.killer.trapper.trap,limit=3,sort=nearest]
tag @s remove this.self

function ./give_item
scoreboard players add @s skill.killer.trapper.count 1

title @s actionbar ""
playsound minecraft:ui.stonecutter.take_result player @s ~ ~ ~ 0.5 2