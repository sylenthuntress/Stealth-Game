from cosmetic:registry import runner_skins
append function_tag level:segment/tick {
    "values": [(~/)]
}

# Runs on all "bumblebee" secrets, every tick, while match is active
execute unless entity @s[tag=segment_entity.secret.bumblebee] run return fail
tag @s add this.self
tag @n[tag=segment_entity.secret.bumblebee,type=item_display] add this.self
tag @n[tag=segment_entity.secret.bumblebee,type=text_display] add this.self
tag @n[tag=segment_entity.secret.bumblebee,type=mannequin] add this.self
tag @a[tag=game.viewing,gamemode=adventure,advancements={completion:runner/find_bumblebee=false}] add this.selected

execute as @e[tag=this.self,type=item_display] at @s expand:
    rotate @s ~6 ~
    tp @s ^ ^ ^-.02
execute as @a[tag=this.selected] expand:
    playsound minecraft:entity.bee.pollinate master @s ~ ~ ~ 0.075 0.793701
    playsound minecraft:entity.bee.pollinate master @s ~ ~ ~ 0.05 0.943874
    execute positioned ~ ~-1 ~ run particle block{block_state:"honey_block"} ~ ~0.75 ~ 0.25 0.5 0.25 0.25 5 force @s

execute if entity @p[distance=..1.5,tag=this.selected] run function ./find_bumblebee:
    advancement grant @a[distance=..1.5,tag=this.selected] only completion:runner/find_bumblebee
    execute positioned ~ ~0.7 ~ run particle minecraft:falling_honey ~ ~ ~ 0.25 0.5 0.25 0.25 50 force @p[distance=..1.5,tag=this.selected]
    playsound minecraft:block.beehive.enter master @p[distance=..1.5,tag=this.selected] ~ ~ ~ 1 1

tag @e remove this.self
tag @a remove this.selected

function ./spawn_bumblebee:
    # Runs when first spawning bumblebee
    setblock ~ ~ ~ air # Clear command block
    summon marker ~ ~ ~ {Tags:["segment_entity.secret.bumblebee","segment_entity.ticking","segment_entity"]}
    summon item_display ~ ~0.7 ~ {Tags:["segment_entity.secret.bumblebee","segment_entity"],teleport_duration: 1, item: {components: {"minecraft:profile": {texture: "hide_and_squeak:entity/player/cosmetic/runner_skin/bumblebee/hiding"}}, count: 1, id: "minecraft:player_head"}, item_display: "head", transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.66f, 0.66f, 0.66f], translation: [0.0f, 0.0f, 0.0f]}}
    
    equipment = []
    for skin in runner_skins:
        if skin.identifier == "cosmetic.runner_skin.bumblebee":
            equipment = skin.get_equipment()
            name = {"translate": "completion.runner.find_bumblebee.desc.2", "color": "green", "with": [skin.get_name()]}
            summon text_display ~ ~0.75 ~ {Tags:["segment_entity.secret.bumblebee","segment_entity"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}
            break
    name = {"translate": "completion.runner.find_bumblebee", "color": "gold"}
    summon text_display ~ ~1 ~ {Tags:["segment_entity.secret.bumblebee","segment_entity"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}
    summon mannequin ~0.5 ~ ~ {Tags:["segment_entity.secret.bumblebee","segment_entity"],pose:"sleeping",attributes:[{id:"minecraft:scale",base:0.66}],equipment:equipment}