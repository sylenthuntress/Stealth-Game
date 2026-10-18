from bolt_expressions import Scoreboard

data merge storage points:data {DisplayText:{"translate":"game.sidebar.value", "with": [[]],"color":"dark_gray"}}

# Add total points to numberformat
display_objective = Scoreboard("game.player.points")
data modify storage points:data DisplayText.with[0] append value {"text":"", "color": "gray"} 

scoreboard players operation $decimal display_objective = @s display_objective
scoreboard players operation $decimal display_objective %= $10 math.const

execute if score $decimal display_objective matches 0 run store result storage points:data DisplayText.with[0][-1].points int 0.1 run scoreboard players get @s display_objective
execute unless score $decimal display_objective matches 0 run store result storage points:data DisplayText.with[0][-1].points float 0.1 run scoreboard players get @s display_objective

data modify storage points:data DisplayText.with[0][-1].text set string storage points:data DisplayText.with[0][-1].points
execute unless score $decimal display_objective matches 0 run data modify storage points:data DisplayText.with[0][-1].text set string storage points:data DisplayText.with[0][-1].text 0 -1
data remove storage points:data DisplayText.with[0][-1].points

scoreboard players reset $decimal display_objective

# Add new points to numberformat
display_objective = Scoreboard("game.player.round_points")
execute if score @s time.player.points_display_timer matches 0 run scoreboard players set @s display_objective 0
execute if entity @a[scores={display_objective=1..}] run data modify storage points:data DisplayText.with[0] append value {"text":"        "} 
execute if score @s display_objective matches 1.. run function render:points/round_points:
    data modify storage points:data DisplayText.with[0][-1] set value {"text":" (+"} 
    data modify storage points:data DisplayText.with[0] append value {"text":""} 

    execute store result storage points:data DisplayText.with[0][-1].points float 0.1 run scoreboard players get @s display_objective

    data modify storage points:data DisplayText.with[0][-1].text set string storage points:data DisplayText.with[0][-1].points
    data modify storage points:data DisplayText.with[0][-1].text set string storage points:data DisplayText.with[0][-1].text 0 -1
    data remove storage points:data DisplayText.with[0][-1].points

    data modify storage points:data DisplayText.with[0] append value {"text":")"} 
    execute if score @s display_objective matches 1.. run expand:
        data modify storage points:data DisplayText.with[0][-3].color set value "green"
        data modify storage points:data DisplayText.with[0][-2].color set value "green"
        data modify storage points:data DisplayText.with[0][-1].color set value "green"
    execute if score @s display_objective matches ..-1 run expand:
        data modify storage points:data DisplayText.with[0][-3].color set value "red"
        data modify storage points:data DisplayText.with[0][-2].color set value "red"
        data modify storage points:data DisplayText.with[0][-1].color set value "red"
    
# Display numberformat after parsing
function render:points/display_numberformat with storage points:data