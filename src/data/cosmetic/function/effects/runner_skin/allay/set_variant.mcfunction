from bolt_expressions import Scoreboard, Data

total_damage = Scoreboard("game.player.damage")
kill_threshold = Scoreboard("game.player.kill_threshold")
percentage = Scoreboard("math.percentage")
percentage["#math.percentage"] = 100 - ((total_damage["@s"] * 100) / kill_threshold["@s"])

tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid.entity = @p[tag=this.self] uid.player run tag @s add this.display

execute if score #math.percentage f"math.percentage" matches 66.. expand:
    execute as @n[type=item_display,tag=this.display] run function animation:cosmetic/runner_skin/allay/hiding_form/variants/neutral/apply
    item modify entity @s armor.head {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/allay/head"}}}
execute if score #math.percentage f"math.percentage" matches 34..65 expand:
    execute as @n[type=item_display,tag=this.display] run function animation:cosmetic/runner_skin/allay/hiding_form/variants/injured/apply
    item modify entity @s armor.head {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/allay/head_injured"}}}
execute if score #math.percentage f"math.percentage" matches ..33 expand:
    execute as @n[type=item_display,tag=this.display] run function animation:cosmetic/runner_skin/allay/hiding_form/variants/critical/apply
    item modify entity @s armor.head {type:"minecraft:set_components",components:{"minecraft:profile":{texture:"hide_and_squeak:entity/player/cosmetic/runner_skin/allay/head_critical"}}}

tag @e remove this.display
tag @s remove this.self