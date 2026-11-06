from cosmetic:registry import Cosmetic
append function_tag level:segment/tick {
    "values": [(~/)]
}

# Runs on all "warden_unlock" secrets, every tick, while match is active
execute unless entity @s[tag=segment_entity.secret.warden_unlock] run return fail
tag @s add this.self
tag @n[tag=segment_entity.secret.warden_unlock,type=item_display] add this.self
tag @n[tag=segment_entity.secret.warden_unlock,type=text_display] add this.self
tag @n[tag=segment_entity.secret.warden_unlock,type=mannequin] add this.self
tag @a[tag=game.viewing,gamemode=adventure,advancements={completion:secret/find_sculk=false}] add this.selected

execute as @e[tag=this.self,type=item_display] at @s expand:
    rotate @s ~6 ~
execute as @a[tag=this.selected] expand:
    playsound minecraft:block.sculk.charge master @s ~ ~ ~ 0.075 0.793701
    playsound minecraft:block.sculk.charge master @s ~ ~ ~ 0.05 0.943874
    execute positioned ~ ~-1 ~ run particle minecraft:sculk_soul ~ ~0.75 ~ 0.25 0.5 0.25 0.01 1 force @s

execute if entity @p[distance=..1.5,tag=this.selected] run function ./find_warden_unlock:
    advancement grant @a[distance=..1.5,tag=this.selected] only completion:secret/find_sculk
    execute positioned ~ ~-1 ~ run particle minecraft:sculk_soul ~ ~0.75 ~ 0.25 0.5 0.25 0.05 50 force @a[distance=..1.5,tag=this.selected]
    playsound minecraft:entity.warden.emerge master @a[distance=..1.5,tag=this.selected] ~ ~ ~ 1 1

tag @e remove this.self
tag @a remove this.selected

function ./spawn_warden_unlock:
    # Runs when first spawning warden_unlock
    setblock ~ ~ ~ air # Clear command block
    summon marker ~ ~ ~ {Tags:["segment_entity.secret.warden_unlock","segment_entity.ticking","segment_entity"]}
    summon item_display ~ ~0.1 ~ {Tags:["segment_entity.secret.warden_unlock","segment_entity"],teleport_duration: 1, item: {components: {"minecraft:item_model":"hide_and_squeak:cosmetic/killer_skin/warden/head"}, count: 1, id: "minecraft:coal"}, item_display: "ground"}
    
    equipment = []
    cosmetic = Cosmetic.getCosmetic("cosmetic.killer_skin.warden")
    equipment = cosmetic.get_equipment()
    name = {"translate": "completion.secret.find_sculk.desc.2", "color": "green", "with": [cosmetic.get_name()]}
    summon text_display ~ ~0.75 ~ {Tags:["segment_entity.secret.warden_unlock","segment_entity"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}

    name = {"translate": "completion.secret.find_sculk", "color": "gold"}
    summon text_display ~ ~1 ~ {Tags:["segment_entity.secret.warden_unlock","segment_entity"],"alignment": "center", "billboard": "vertical", "background": 0, "default_background": 0b, "line_width": 200, "see_through": 0b, "shadow": 0b, "text": name, "text_opacity": -1b}