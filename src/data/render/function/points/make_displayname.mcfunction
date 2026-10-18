data merge storage points:data {DisplayName:{"translate":"game.sidebar.name","with":[{"text":""}],"color":"dark_gray"}}

execute at @s:
    loot spawn ~ ~ ~ loot {type:"minecraft:generic",pools:[{rolls:1,entries:[{type:"minecraft:item",name:"minecraft:player_head"}]}],modifier:{type:"minecraft:fill_player_head",entity:"this"}}
    data modify storage points:data DisplayName.with[0].text set from entity @n[type=item] Item.components."minecraft:profile".name
    kill @n[type=item]

execute if entity @s[team=killer] run data modify storage points:data DisplayName.with[0].color set value "gold"
execute if entity @s[team=runner] run data modify storage points:data DisplayName.with[0].color set value "gray"
execute if entity @s[team=dead] run data modify storage points:data DisplayName.with[0].color set value "dark_gray"
execute if entity @s[team=dead] run data modify storage points:data DisplayName.with[0].strikethrough set value true

function render:points/set_displayname with storage points:data