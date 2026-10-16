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

tag @s add this.selector
item replace entity @n[tag=game.runner_corpse] armor.head with player_head
item modify entity @n[tag=game.runner_corpse] armor.head {type:"minecraft:fill_player_head",entity:"this"}
execute as @n[tag=game.runner_corpse] expand:
    team join dead
    scoreboard players operation @s uid.entity = @p[tag=this.selector] uid.player
    data modify entity @s CustomName set from entity @s equipment.head.components."minecraft:profile".name
    item replace entity @s armor.head with air
tag @s remove this.selector