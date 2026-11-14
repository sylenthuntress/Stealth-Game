from cosmetic:registry import Cosmetic
append function_tag level:segment/tick {
    "values": [(~/)]
}

# Runs on all "wither_unlock" secrets, every tick, while match is active
execute unless entity @s[tag=segment_entity.secret.wither_unlock] run return fail
execute if entity @e[distance=..10,type=marker,tag=segment_entity.secret.wither_unlock.skulldoor] run return fail
tag @s add this.self
tag @n[tag=segment_entity.secret.wither_unlock,type=item_display] add this.self
tag @n[tag=segment_entity.secret.wither_unlock,type=text_display] add this.self
tag @n[tag=segment_entity.secret.wither_unlock,type=mannequin] add this.self
tag @a[tag=game.viewing,gamemode=adventure,advancements={completion:secret/find_wither=false}] add this.selected

execute as @e[tag=this.self,type=item_display] at @s expand:
    rotate @s ~6 ~
execute as @a[tag=this.selected] expand:
    playsound minecraft:entity.wither.ambient master @s ~ ~ ~ 0.0025 0.793701
    playsound minecraft:entity.wither.ambient master @s ~ ~ ~ 0.001 0.943874
    execute positioned ~ ~-1 ~ run particle minecraft:smoke ~ ~0.75 ~ 0.25 0.5 0.25 0.01 1 force @s

execute if entity @p[distance=..1.5,tag=this.selected] run function ./find_wither_unlock:
    advancement grant @a[distance=..1.5,tag=this.selected] only completion:secret/find_wither
    execute positioned ~ ~-1 ~ run particle minecraft:smoke ~ ~0.75 ~ 0.25 0.5 0.25 0.05 50 force @a[distance=..1.5,tag=this.selected]
    playsound minecraft:entity.wither.shoot master @a[distance=..1.5,tag=this.selected] ~ ~ ~ 1 1

tag @e remove this.self
tag @a remove this.selected

function ./spawn_wither_unlock:
    # Runs when first spawning wither_unlock
    setblock ~ ~ ~ air # Clear command block
    summon marker ~ ~ ~ {Tags:["segment_entity.secret.wither_unlock","segment_entity.ticking","segment_entity"]}
    summon item_display ~ ~0.1 ~ {Tags:["segment_entity.secret.wither_unlock","segment_entity"],teleport_duration: 1, item: {components: {"minecraft:item_model":"hide_and_squeak:cosmetic/killer_skin/wither/head"}, count: 1, id: "minecraft:coal"}, item_display: "ground"}
    
    equipment = []
    cosmetic = Cosmetic.getCosmetic("cosmetic.killer_skin.wither")
    equipment = cosmetic.get_equipment()
    name = {"translate": "completion.secret.find_sculk.desc.2", "color": "green", "with": [cosmetic.get_name()]}
    summon text_display ~ ~0.75 ~ {Tags:["segment_entity.secret.wither_unlock","segment_entity"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}

    name = {"translate": "completion.secret.find_sculk", "color": "gold"}
    summon text_display ~ ~1 ~ {Tags:["segment_entity.secret.wither_unlock","segment_entity"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}

function ~/tick_skullcheck:
    append function_tag level:segment/tick {
        "values": [(~/)]
    }

    # Runs on all "wither_unlock" secrets, every tick, while match is active
    execute unless entity @s[tag=segment_entity.secret.wither_unlock.skullcheck] run return fail

    execute unless block ~ ~ ~ minecraft:wither_skeleton_skull run particle minecraft:smoke ~ ~ ~ 0 0 0.1 0.01 1 normal
    execute positioned ~-1 ~ ~ unless block ~ ~ ~ minecraft:wither_skeleton_skull run particle minecraft:smoke ~ ~ ~ 0 0 0.1 0.01 1 normal

    execute if block ~ ~ ~ minecraft:wither_skeleton_skull if block ~-1 ~ ~ minecraft:wither_skeleton_skull run function ~/../open_skulldoor:
        tellraw @a[tag=game.viewing] {"translate":"completion.secret.find_wither.open_sculkdoor","color":"#76527d"}
        execute at @n[type=marker,tag=segment_entity.secret.wither_unlock.skulldoor] expand:
            fill ~1 ~ ~-.5 ~ ~2 ~1 minecraft:air destroy
            playsound minecraft:entity.wither.break_block master @a ~ ~ ~ 1 1 1
        kill @n[type=marker,tag=segment_entity.secret.wither_unlock.skulldoor]
        kill @s

function ~/spawn_skullcheck:
    # Runs when first spawning wither_unlock
    setblock ~ ~ ~ air # Clear command block
    summon marker ~ ~ ~ {Tags:["segment_entity.secret.wither_unlock.skullcheck","segment_entity.ticking","segment_entity"]}

function ~/spawn_skulldoor:
    # Runs when first spawning wither_unlock
    setblock ~ ~ ~ air # Clear command block
    summon marker ~ ~ ~.5 {Tags:["segment_entity.secret.wither_unlock.skulldoor","segment_entity.ticking","segment_entity"]}