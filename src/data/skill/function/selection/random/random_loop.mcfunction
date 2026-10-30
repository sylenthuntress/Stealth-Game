function skill:selection/random/get_index with storage skill:data Random.args

scoreboard objectives add var.predicate dummy
execute store result score #var var.tag_applied run function ./random_tag with storage skill:data Random.args
function ./random_tag:
    $data modify storage skill:data Random.args.skill set from storage skill:data Random.list[$(target_index)]
    return run function ./add_tag with storage skill:data Random.args.skill
scoreboard objectives remove var.predicate

function ./remove_option with storage skill:data Random.args
function ./remove_option:
    $data remove storage skill:data Random.list[$(target_index)]
    execute store result storage skill:data Random.args.max_index int 1 run scoreboard players remove #var var.max_index 1

execute if score #var var.tag_applied matches 1 run scoreboard players remove #var var.times 1
execute if score #var var.times matches 1.. if data storage skill:data Random.list[0] run function ~/