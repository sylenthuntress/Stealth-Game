$summon mannequin ~ ~ ~ {Tags:["skill.killer.gemini.clone","this.summoned"],profile:{"id":$(UUID)},Rotation:$(Rotation),Health:999f,attributes:[{id:"minecraft:max_health",base:999}],CustomNameVisible:true,hide_description:true}

tag @s add this.selector
scoreboard players set @n[tag=this.summoned] skill.killer.gemini.clone.health 10
item replace entity @n[tag=this.summoned] armor.head with player_head
item modify entity @n[tag=this.summoned] armor.head {type:"minecraft:fill_player_head",entity:"this"}
execute as @n[tag=this.summoned] run function ./set_mannequin
tag @s remove this.selector