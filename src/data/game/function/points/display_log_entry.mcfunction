$scoreboard players reset $scoredisplay.$(name)_$(index) game.player.points

$scoreboard players operation $scoredisplay.$(name)_$(index) game.player.points = $scoredisplay game.player.points
scoreboard players add $scoredisplay game.player.points 1

$scoreboard players display name $scoredisplay.$(name)_$(index) game.player.points {"translate":"game.sidebar.point_log.name","with": [{"text": $(name),"color":"gray"}],"color":"dark_gray"}
$scoreboard players display numberformat $scoredisplay.$(name)_$(index) game.player.points blank

scoreboard objectives add var.points_decimal dummy
scoreboard objectives add var.points_whole dummy

$scoreboard players set $var var.points_whole $(points)
scoreboard players operation $var var.points_whole /= $10 math.const
$scoreboard players set $var var.points_decimal $(points)
scoreboard players operation $var var.points_decimal %= $10 math.const

$execute unless score $var var.points_decimal matches 0 run scoreboard players display numberformat $scoredisplay.$(name)_$(index) game.player.points fixed {"translate":"game.sidebar.point_log.value","with": [[{"text": "+","color": "green"},{"score": {"name": "$var","objective": "var.points_whole"}},".",{"score": {"name": "$var","objective": "var.points_decimal"}}]],"color":"dark_gray"}
$execute if score $var var.points_decimal matches 0 run scoreboard players display numberformat $scoredisplay.$(name)_$(index) game.player.points fixed {"translate":"game.sidebar.point_log.value","with": [[{"text": "+","color": "green"},{"score": {"name": "$var","objective": "var.points_whole"}}]],"color":"dark_gray"}

# Remove unneeded variables
scoreboard objectives remove var.points_decimal
scoreboard objectives remove var.points_whole