# Add tags
tag @s add this.projectile
execute on origin run tag @s add this.origin

# Get initial motion based on charge time
execute on origin rotated as @s positioned 0.0 0.0 0.0 summon area_effect_cloud if function skill:weapon/foreseer/calculate_motion run data modify entity @n[tag=this.projectile] Motion set from entity @s Pos
function skill:weapon/foreseer/calculate_motion:
    execute unless score @p[tag=this.origin] skill.weapon.foreseer.charge_time matches 1.. run return run tp ~ ~ ~
    scoreboard players remove @p[tag=this.origin] skill.weapon.foreseer.charge_time 1
    execute positioned ^ ^ ^.15 run return run function skill:weapon/foreseer/calculate_motion

# Add player motion to arrow
execute as @p[tag=this.origin] expand:
    store result score @s skill.weapon.foreseer.motion.x run data get entity @s Motion[0] 1000
    store result score @s skill.weapon.foreseer.motion.y run data get entity @s Motion[1] 1000
    store result score @s skill.weapon.foreseer.motion.z run data get entity @s Motion[2] 1000

execute store result score @s skill.weapon.foreseer.motion.x run data get entity @s Motion[0] 1000
execute store result score @s skill.weapon.foreseer.motion.y run data get entity @s Motion[1] 1000
execute store result score @s skill.weapon.foreseer.motion.z run data get entity @s Motion[2] 1000

scoreboard players operation @s skill.weapon.foreseer.motion.x += @p[tag=this.origin] skill.weapon.foreseer.motion.x
scoreboard players operation @s skill.weapon.foreseer.motion.y += @p[tag=this.origin] skill.weapon.foreseer.motion.y
scoreboard players operation @s skill.weapon.foreseer.motion.z += @p[tag=this.origin] skill.weapon.foreseer.motion.z

execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s skill.weapon.foreseer.motion.x
execute store result entity @s Motion[1] double 0.001 run scoreboard players get @s skill.weapon.foreseer.motion.y
execute store result entity @s Motion[2] double 0.001 run scoreboard players get @s skill.weapon.foreseer.motion.z

# Remove tags
tag @s remove this.projectile
tag @a remove this.origin

# Reset charge time for next use
execute on origin run scoreboard players reset @s skill.weapon.foreseer.charge_time