scoreboard objectives add var.max_index dummy
scoreboard objectives add var.tag_applied dummy

execute store result score $var var.max_index if data storage skill:selection Options[]
execute store result storage skill:random args.max_index int 1 run scoreboard players remove $var var.max_index 1
execute store result storage skill:random args.uid int 1 run scoreboard players get @s uid.player
data modify storage skill:random list set from storage skill:registry WeaponRegistry

scoreboard objectives add var.times dummy
scoreboard players operation $var var.times = $config config.slots.weapon

execute function skill:selection/random_loop:
    function skill:selection/random/get_index with storage skill:random args
    execute store result score $var var.tag_applied run function skill:selection/random/random_tag with storage skill:random args

    execute if score $var var.tag_applied matches 1 run scoreboard players remove $var var.times 1
    execute if score $var var.times matches 1.. run function skill:selection/random_loop

scoreboard objectives remove var.max_index
scoreboard objectives remove var.tag_applied
scoreboard objectives remove var.times