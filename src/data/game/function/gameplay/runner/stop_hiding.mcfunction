tag @s add this.self
execute as @e[type=item_display,tag=little_mouse] if score @s uid.entity = @p uid.player run tag @s add this.display

tag @s remove hiding
particle minecraft:block_crumble{block_state:"minecraft:white_wool"} ~ ~ ~ 0.2 0.5 0.2 1 10 normal @a

effect clear @s invisibility
execute store result storage var:glow_timer duration int 0.05 run scoreboard players get @n[type=item_display,tag=this.display] time.entity.glow_timer
function ./transfer_hiding with storage var:glow_timer
function ./transfer_hiding:
    $effect give @s minecraft:glowing $(duration) 0
data remove storage var:glow_timer duration

attribute @s minecraft:camera_distance modifier remove game:gameplay/runner/hiding
attribute @s minecraft:scale modifier remove game:gameplay/runner/hiding
attribute @s minecraft:sneaking_speed modifier remove game:gameplay/runner/hiding
attribute @s minecraft:attack_damage modifier remove game:gameplay/runner/hiding
attribute @s minecraft:jump_strength modifier remove game:gameplay/runner/hiding
attribute @s minecraft:gravity modifier remove game:gameplay/runner/hiding
attribute @s minecraft:step_height modifier remove game:gameplay/runner/hiding
scoreboard players set @s time.player.hide_timer 0

tag @s remove this.self
kill @n[type=item_display,tag=this.display]