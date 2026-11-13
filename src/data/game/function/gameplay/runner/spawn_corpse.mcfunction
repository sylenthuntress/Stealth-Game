$summon mannequin ~ ~ ~ {       \
    Tags:["game.runner_corpse"],\
    Invulnerable:true,          \
    profile:{"id":$(UUID)},     \
    Rotation:$(Rotation),       \
    Health:999f,                \
    attributes:$(attributes),   \
    equipment:$(equipment),     \
    CustomNameVisible:true,     \
    hide_description:true,      \
    pose:"sleeping"             \
}

item replace entity @n[tag=game.runner_corpse] armor.head with player_head
item modify entity @n[tag=game.runner_corpse] armor.head {type:"minecraft:fill_player_head",entity:"this"}
team join dead @n[tag=game.runner_corpse]
scoreboard players operation @n[tag=game.runner_corpse] uid.entity = @s uid.player
data modify entity @n[tag=game.runner_corpse] CustomName set from entity @n[tag=game.runner_corpse] equipment.head.components."minecraft:profile".name
effect give @n[tag=game.runner_corpse] invisibility infinite 0 true
execute at @s run rotate @n[tag=game.runner_corpse] ~ 0