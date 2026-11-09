function player:prepare_store

data modify storage player:data players[-1].actionbar.duration set compute default integer {type:"minecraft:add",inputs:[-1,{type:"minecraft:storage",storage:"player:data",path:"players[-1].actionbar.duration"}]}
scoreboard objectives add var.duration dummy
execute store result score #var var.duration run data get storage player:data players[-1].actionbar.duration
execute unless score #var var.duration matches 1.. run data remove storage player:data players[-1].actionbar
scoreboard objectives remove var.duration

data modify storage player:data players[-1].actionbar.constant_text set from storage actionbar:data selector.constant_text

title @s actionbar [{nbt:"players[-1].actionbar.constant_text",storage:"player:data",interpret:true},{nbt:"players[-1].actionbar.text",storage:"player:data",interpret:true}]