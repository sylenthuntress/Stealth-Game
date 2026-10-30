scoreboard objectives add var.max_index dummy
scoreboard objectives add var.tag_applied dummy

execute store result score #var var.max_index if data storage skill:data Registry[{"type":"skill:runner"}]
execute store result storage skill:data Random.args.max_index int 1 run scoreboard players remove #var var.max_index 1
execute store result storage skill:data Random.args.uid int 1 run scoreboard players get @s uid.player
data modify storage skill:data Random.list set value []
data modify storage skill:data Random.list append from storage skill:data Registry[{"type":"skill:runner"}]
data modify storage skill:data Random.args.registry set value "runner_skill"

scoreboard objectives add var.times dummy
scoreboard players operation #var var.times = #config config.slots.runner_skill

function ./random_loop

scoreboard objectives remove var.max_index
scoreboard objectives remove var.tag_applied
scoreboard objectives remove var.times