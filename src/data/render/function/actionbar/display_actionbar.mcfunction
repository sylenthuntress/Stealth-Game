## {uid: int, constant_text: Text}
$data modify storage actionbar:data players[{uid:$(uid)}].duration set compute default integer {type:"minecraft:add",inputs:[-1,{type:"minecraft:storage",storage:"actionbar:data",path:"players[{uid: $(uid)}].duration"}]}
scoreboard objectives add var.duration dummy
$execute store result score #var var.duration run data get storage actionbar:data players[{uid:$(uid)}].duration
$execute unless score #var var.duration matches 1.. run data remove storage actionbar:data players[{uid:$(uid)}]
scoreboard objectives remove var.duration

$function util:display_actionbar {"title": ["",$(constant_text)," ",{"storage": "actionbar:data", "nbt": "players[{uid: $(uid)}].text", "interpret": true, "seperator": {"text":""}}]}