scoreboard players operation @s uid.entity = @p[tag=this.selector] uid.player
team join killer

data modify entity @s CustomName set from entity @s equipment.head.components."minecraft:profile".name
item replace entity @s armor.head with air