tag @s add this.self
execute as @e[tag=hiding_form,tag=!skill.runner.puppeteer.hiding_form] if score @s uid = @p uid run tag @s add this.display

tag @s remove hiding

execute store result storage var:glow_timer duration int 0.05 run scoreboard players get @n[tag=this.display] time.entity.glow_timer
function ./transfer_hiding with storage var:glow_timer
function ./transfer_hiding:
    $effect give @s minecraft:glowing $(duration) 0
data remove storage var:glow_timer duration

attribute @s minecraft:camera_distance modifier remove game:gameplay/runner/hiding
attribute @s minecraft:sneaking_speed modifier remove game:gameplay/runner/hiding
attribute @s minecraft:attack_damage modifier remove game:gameplay/runner/hiding
attribute @s minecraft:jump_strength modifier remove game:gameplay/runner/hiding
attribute @s minecraft:gravity modifier remove game:gameplay/runner/hiding
attribute @s minecraft:step_height modifier remove game:gameplay/runner/hiding
scoreboard players set @s time.player.hide_timer 0

tag @s remove this.self

execute if function cosmetic:effects/stop_hiding run return 1
function cosmetic:add_equipment

tp @n[tag=this.display] ~ -60 ~
execute as @n[tag=this.display] on passengers run kill @s
kill @n[tag=this.display]