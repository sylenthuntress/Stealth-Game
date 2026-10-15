$summon mannequin ~ ~ ~ {Tags:["skill.killer_skill.gemini.clone"],profile:{"id":$(UUID)},Rotation:$(Rotation),Health:999f,attributes:[{id:"minecraft:max_health",base:999}],CustomNameVisible:true,hide_description:true}

tag @s add this.selector
scoreboard players set @n[tag=skill.killer_skill.gemini.clone] skill.killer.gemini.clone.health 10
item replace entity @n[tag=skill.killer_skill.gemini.clone] armor.head with player_head
item modify entity @n[tag=skill.killer_skill.gemini.clone] armor.head {type:"minecraft:fill_player_head",entity:"this"}
execute as @n[tag=skill.killer_skill.gemini.clone] run function skill:killer_skill/gemini/set_mannequin
tag @s remove this.selector