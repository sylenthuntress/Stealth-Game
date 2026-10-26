from bolt_expressions import Scoreboard

total_damage = Scoreboard("game.player.damage")
kill_threshold = Scoreboard("game.player.kill_threshold")
percentage = Scoreboard("math.percentage")
percentage["#math"] = 100 - ((total_damage["@s"] * 100) / kill_threshold["@s"])

data remove storage actionbar:data selector
execute store result storage actionbar:data selector.uid int 1 run scoreboard players get @s uid.player
data modify storage actionbar:data selector.constant_text append value ""

execute if entity @s[gamemode=!spectator] run function ./health_text:
    data modify storage actionbar:data selector.constant_text append value {"color":"gray","translate":"", "with": [[{"score": {"name":"#math", "objective":"math.percentage"},"color":"gray","bold":true},{"text":"%"}]]}

    execute if score #math f"math.percentage" matches 66.. run data modify storage actionbar:data selector.constant_text[-1].translate set value "gameplay.player.actionbar.health.high" 
    execute if score #math f"math.percentage" matches 66.. run data modify storage actionbar:data selector.constant_text[-1].with[0][0].color set value "green" 
    execute if score #math f"math.percentage" matches 34..65 run data modify storage actionbar:data selector.constant_text[-1].translate set value "gameplay.player.actionbar.health.med" 
    execute if score #math f"math.percentage" matches 34..65 run data modify storage actionbar:data selector.constant_text[-1].with[0][0].color set value "yellow" 
    execute if score #math f"math.percentage" matches ..33 run data modify storage actionbar:data selector.constant_text[-1].translate set value "gameplay.player.actionbar.health.low" 
    execute if score #math f"math.percentage" matches ..33 run data modify storage actionbar:data selector.constant_text[-1].with[0][0].color set value "red" 

    execute if entity @s[tag=hiding] run data modify storage actionbar:data selector.constant_text[-1].translate set value "gameplay.player.actionbar.hiding"
    execute if entity @s[tag=hiding] run data modify storage actionbar:data selector.constant_text[-1].color set value "dark_gray"

## Display actionbar
function ./display_actionbar with storage actionbar:data selector