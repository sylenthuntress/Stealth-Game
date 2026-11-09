from bolt_expressions import Scoreboard

total_damage = Scoreboard("game.player.damage")
injuries = Scoreboard("game.player.injury")
kill_threshold = Scoreboard("game.player.kill_threshold")
kill_threshold_default = 300
kill_threshold_diff = kill_threshold_default - kill_threshold["@s"]

percentage = Scoreboard("math.percentage")
percentage["#math.scaled"] = 100 - ((total_damage["@s"] * 100) + (kill_threshold_diff * 100)) / kill_threshold_default
percentage["#math.total"] = 100 - (total_damage["@s"] * 100) / kill_threshold["@s"]

data remove storage actionbar:data selector
data modify storage actionbar:data selector.constant_text append value ""

execute if entity @s[gamemode=!spectator] run function ./health_text:
    data modify storage actionbar:data selector.constant_text append value {"color":"gray","translate":"gameplay.player.actionbar.health", "with": [[{"score": {"name":"#math.scaled", "objective":"math.percentage"},"color":"gray","bold":true},{"text":"%"}]]}
    #✗
    execute if score #math.total f"math.percentage" matches 66.. run data modify storage actionbar:data selector.constant_text[-1].with[0][0].color set value "green" 
    execute if score #math.total f"math.percentage" matches 34..65 run data modify storage actionbar:data selector.constant_text[-1].with[0][0].color set value "yellow" 
    execute if score #math.total f"math.percentage" matches ..33 run data modify storage actionbar:data selector.constant_text[-1].with[0][0].color set value "red" 

    execute if entity @s[tag=hiding] run data modify storage actionbar:data selector.constant_text[-1].translate set value "gameplay.player.actionbar.hiding"
    execute if entity @s[tag=hiding] run data modify storage actionbar:data selector.constant_text[-1].color set value "dark_gray"

    percentage["#math.total"] = (injuries["@s"] * 100) / kill_threshold["@s"]
    if percentage["#math.total"] > 0: 
        execute function ./injury_text:
            data modify storage actionbar:data selector.constant_text[-1].with[0] append value {"translate": "gameplay.player.actionbar.injury", "color": "gray", "bold": false, "with": [[{"score": {"name":"#math.total", "objective":"math.percentage"}},{"text": "✗", "bold": true}]]}
                execute if score #math.total f"math.percentage" matches ..33 run data modify storage actionbar:data selector.constant_text[-1].with[0][-1].with[0][0].color set value "#e5a294" 
                execute if score #math.total f"math.percentage" matches 34..65 run data modify storage actionbar:data selector.constant_text[-1].with[0][-1].with[0][0].color set value "#af5645" 
                execute if score #math.total f"math.percentage" matches 66.. run data modify storage actionbar:data selector.constant_text[-1].with[0][-1].with[0][0].color set value "#8c3019" 
## Display actionbars
function ./display_actionbar