$summon mannequin ~ ~ ~ {       \
    Tags:["game.runner_corpse"],\
    Invulnerable:true,          \
    profile:{"id":$(UUID)},     \
    Rotation:$(Rotation),       \
    Health:999f,                \
    attributes:$(attributes),   \
    CustomNameVisible:true,     \
    hide_description:true,      \
    pose:"sleeping"             \
}

item replace entity @n[tag=game.runner_corpse] armor.head with player_head
item modify entity @n[tag=game.runner_corpse] armor.head {type:"minecraft:fill_player_head",entity:"this"}
team join dead @n[tag=game.runner_corpse]
scoreboard players operation @n[tag=game.runner_corpse] uid = @s uid
data modify entity @n[tag=game.runner_corpse] CustomName set from entity @n[tag=game.runner_corpse] equipment.head.components."minecraft:profile".name
effect give @n[tag=game.runner_corpse] invisibility infinite 0 true
execute at @s run rotate @n[tag=game.runner_corpse] ~ 0

function player:get/cosmetics
data modify storage cosmetic:temp Recursive append from storage player:data selected.cosmetics[{"type": "cosmetic:runner/skin"}].components."cosmetic:equipment"[]
execute as @n[tag=game.runner_corpse] run function ./corpse_equipment with storage cosmetic:temp Recursive[0]
function ./corpse_equipment:
    $item replace entity @s weapon.mainhand with $(id) 1
    $item modify entity @s weapon.mainhand {type:"minecraft:set_components",components:$(components)}
    $item replace entity @s $(slot) from entity @s weapon.mainhand
    item replace entity @s weapon.mainhand with air

    data remove storage cosmetic:temp Recursive[0]
    execute if data storage cosmetic:temp Recursive[0] run function ~/ with storage cosmetic:temp Recursive[0]