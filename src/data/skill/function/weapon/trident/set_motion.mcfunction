# Add tags
tag @s add this.projectile
execute on origin run tag @s add this.origin

# Get initial motion based on charge time
execute on origin rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^3 summon area_effect_cloud store success entity @s Duration int 1 run data modify entity @n[tag=this.projectile] Motion set from entity @s Pos

# Add player motion to arrow
execute as @p[tag=this.origin] expand:
    store result score @s skill.weapon.trident.motion.x run data get entity @s Motion[0] 1000
    store result score @s skill.weapon.trident.motion.y run data get entity @s Motion[1] 1000
    store result score @s skill.weapon.trident.motion.z run data get entity @s Motion[2] 1000

execute store result score @s skill.weapon.trident.motion.x run data get entity @s Motion[0] 1000
execute store result score @s skill.weapon.trident.motion.y run data get entity @s Motion[1] 1000
execute store result score @s skill.weapon.trident.motion.z run data get entity @s Motion[2] 1000

scoreboard players operation @s skill.weapon.trident.motion.x += @p[tag=this.origin] skill.weapon.trident.motion.x
scoreboard players operation @s skill.weapon.trident.motion.y += @p[tag=this.origin] skill.weapon.trident.motion.y
scoreboard players operation @s skill.weapon.trident.motion.z += @p[tag=this.origin] skill.weapon.trident.motion.z

execute store result entity @s Motion[0] double 0.001 run scoreboard players get @s skill.weapon.trident.motion.x
execute store result entity @s Motion[1] double 0.001 run scoreboard players get @s skill.weapon.trident.motion.y
execute store result entity @s Motion[2] double 0.001 run scoreboard players get @s skill.weapon.trident.motion.z

# Remove tags
tag @s remove this.projectile
tag @a remove this.origin