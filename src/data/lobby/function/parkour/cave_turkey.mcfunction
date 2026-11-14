from cosmetic:registry import Cosmetic
append function_tag level:segment/tick {
    "values": [(~/)]
}

execute unless entity @s[tag=lobby.parkour.cave_turkey] run return fail
tag @s add this.self
tag @e[tag=lobby.parkour.cave_turkey] add this.self
tag @a[tag=lobby,gamemode=adventure,advancements={completion:lobby/complete_parkour=false}] add this.selected
execute unless entity @a[tag=this.selected] unless entity @a[distance=..6] run return fail

execute as @e[tag=this.self,type=item_display] at @s run function ./turkey_display:
    execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:periodic_tick":100}} run playsound minecraft:entity.chicken_picky.ambient master @a[distance=..6] ~ ~ ~ 0.075 0.793701
    execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:periodic_tick":100}} run playsound minecraft:entity.chicken_picky.ambient master @a[distance=..6] ~ ~ ~ 0.05 0.943874
    execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:periodic_tick":7}} run playsound minecraft:entity.chicken_picky.step master @a[distance=..6] ~ ~ ~ 0.1 1.5
    execute positioned ^ ^ ^.2 unless block ~ ~ ~ air run rotate @s ~100 0
    execute positioned ^ ^ ^.2 if block ~ ~ ~ air run tp @s ~ ~ ~
execute as @a[tag=this.selected] expand:
    execute positioned ~ ~-1 ~ run particle block{block_state:"brown_wool"} ~ ~0.75 ~ 0.25 0.5 0.25 0.25 5 force @s

execute if entity @p[distance=..1.5,tag=this.selected] run function ./find_turkey:
    advancement grant @a[distance=..1.5,tag=this.selected] only completion:lobby/complete_parkour
    execute positioned ~ ~0.7 ~ run particle minecraft:block_crumble{block_state:"minecraft:brown_wool"} ~ ~ ~ 0.25 0.5 0.25 0.25 50 force @p[distance=..1.5,tag=this.selected]
    playsound minecraft:entity.chicken_picky.hurt master @p[distance=..1.5,tag=this.selected] ~ ~ ~ 1 2

tag @e remove this.self
tag @a remove this.selected

function ./spawn_turkey:
    setblock ~ ~ ~ air # Clear command block
    summon marker ~ ~ ~ {Tags:["lobby.parkour.cave_turkey"]}
    function animation:cosmetic/runner_skin/cave_turkey/hiding_form/summon {args: {}}
    execute as @e[type=item_display,tag=this.summoned,tag=animation.cosmetic.runner_skin.cave_turkey.hiding_form.root] run function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/walking/play
    tag @e[type=item_display,tag=this.summoned,tag=animation.cosmetic.runner_skin.cave_turkey.hiding_form.root] add lobby.parkour.cave_turkey
    tag @e[type=item_display,tag=this.summoned] remove this.summoned

    equipment = []
    cosmetic = Cosmetic.getCosmetic("cosmetic.runner_skin.cave_turkey")
    equipment = cosmetic.get_equipment()
    name = {"translate": "completion.lobby.complete_parkour.desc.2", "color": "green", "with": [cosmetic.get_name()]}
    summon text_display ~ ~1.75 ~ {Tags:["lobby.parkour.cave_turkey"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}

    name = {"translate": "completion.lobby.complete_parkour", "color": "gold"}
    summon text_display ~ ~2 ~ {Tags:["lobby.parkour.cave_turkey"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}

function ./kill_turkey:
    tag @e[tag=lobby.parkour.cave_turkey] add this.self

    execute as @e[tag=this.self] on passengers run kill @s
    kill @e[tag=this.self]