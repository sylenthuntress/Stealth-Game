$summon mannequin ~ ~ ~ {Tags:["skill.runner.puppeteer.puppet"],profile:{"id":$(UUID)},Rotation:$(Rotation),Health:999f,attributes:[{id:"minecraft:scale",base:0.66f},{id:"minecraft:max_health",base:999f}],CustomNameVisible:false}

effect give @n[type=mannequin,tag=skill.runner.puppeteer.puppet] invisibility infinite 0 true
scoreboard players operation @n[type=mannequin,tag=skill.runner.puppeteer.puppet] uid = @p[tag=this.selector] uid
team join runner @n[type=mannequin,tag=skill.runner.puppeteer.puppet]
execute as @n[type=mannequin,tag=skill.runner.puppeteer.puppet] at @s run rotate @s ~ 0

execute as @p[tag=this.selector] run function player:get/cosmetics
data modify storage cosmetic:data Selection.Recursive set value []
data modify storage cosmetic:data Selection.Recursive append from storage player:data selected.cosmetics[{"type": "cosmetic:runner/skin"}]
execute as @n[type=mannequin,tag=skill.runner.puppeteer.puppet] run function cosmetic:selection/add_tag with storage cosmetic:data Selection.Recursive[0]