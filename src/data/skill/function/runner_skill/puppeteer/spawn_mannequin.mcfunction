$summon mannequin ~ ~ ~ {Tags:["skill.runner_skill.puppeteer.puppet"],profile:{"id":$(UUID)},Rotation:$(Rotation),Health:999f,attributes:[{id:"minecraft:scale",base:0.66f},{id:"minecraft:max_health",base:999f}],CustomNameVisible:false}

item replace entity @n[type=mannequin,tag=skill.runner_skill.puppeteer.puppet] armor.head with player_head
item modify entity @n[type=mannequin,tag=skill.runner_skill.puppeteer.puppet] armor.head {type:"minecraft:fill_player_head",entity:"this"}
execute as @n[type=mannequin,tag=skill.runner_skill.puppeteer.puppet] expand:
    scoreboard players operation @s uid.entity = @p[tag=this.selector] uid.player
    team join runner

    data modify entity @s CustomName set from entity @s equipment.head.components."minecraft:profile".name
    item replace entity @s armor.head with air