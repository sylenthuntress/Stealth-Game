scoreboard players operation @s uid = @p[tag=this.selector] uid
team join killer

data modify entity @s CustomName set from entity @s equipment.head.components."minecraft:profile".name
item replace entity @s armor.* from entity @p armor.*