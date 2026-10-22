function skill:selection/random/get_index with storage skill:random args
execute store result score #var var.tag_applied run function skill:selection/random/random_tag with storage skill:random args

execute if score #var var.tag_applied matches 1 run scoreboard players remove #var var.times 1
execute if score #var var.times matches 1.. run function ./random_loop