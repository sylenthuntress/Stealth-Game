execute unless data storage player:data players run return run function ./init
execute unless data storage player:data players[-1].uid run return 1

scoreboard objectives add var.test dummy

data modify storage player:data test set from storage player:data players[-1].uid
execute store result score #var var.test run data modify storage player:data test set from storage player:data selected.uid
data remove storage player:data test

return run execute unless score #var var.test matches 1