# Initialize button
data modify storage cosmetic:data Selection.dialog.actions append value {"tooltip": {"translate": ""}, width: 100, action: {"type": "minecraft:run_command", "command": ""}}
data modify storage cosmetic:data Selection.dialog.actions[-1].label set from storage cosmetic:data Selection.Recursive[0].title
data modify storage cosmetic:data Selection.dialog.actions[-1].label.with set value [{"color": "white"}]
data modify storage cosmetic:data Selection.dialog.actions[-1].label.with[0].sprite set from storage cosmetic:data Selection.Recursive[0].icon.sprite
data modify storage cosmetic:data Selection.dialog.actions[-1].label.with[0].atlas set from storage cosmetic:data Selection.Recursive[0].icon.atlas
data modify storage cosmetic:data Selection.dialog.actions[-1].label.with[0].player set from storage cosmetic:data Selection.Recursive[0].icon.player
data modify storage cosmetic:data Selection.dialog.actions[-1].label.with[0].object set from storage cosmetic:data Selection.Recursive[0].icon.object
data modify storage cosmetic:data Selection.dialog.actions[-1].width set from storage cosmetic:data Selection.Recursive[0].width
data modify storage cosmetic:data Selection.dialog.actions[-1].tooltip set from storage cosmetic:data Selection.Recursive[0].desc
data modify storage cosmetic:data Selection.dialog.actions[-1].tooltip append from storage cosmetic:data Selection.Recursive[0].components."cosmetic:features"
execute if data storage cosmetic:data Selection.Recursive[0].components{"cosmetic:default": true} run data modify storage cosmetic:data Selection.dialog.actions[-1].default set value true 

# Set on-click behavior
execute store result storage cosmetic:data Selection.Recursive[0].uid int 1 run scoreboard players get @s uid.player 
function ./set_command with storage cosmetic:data Selection.Recursive[0]
function ./set_command:
    $data modify storage cosmetic:data Selection.dialog.actions[-1].action.command set value "trigger cosmetic.selection set $(numid)" 

# Check if option is locked or equipped
scoreboard objectives add var.locked dummy
execute store result score #var var.locked run function ./check_locked:
    execute if data storage cosmetic:data Selection.Recursive[0].components{"cosmetic:default": true} run return fail

    data modify storage cosmetic:data Selection.Recursive[0].query.Recursive set from storage cosmetic:data Selection.Recursive[0].components."cosmetic:unlockable".advancements
    execute if data storage cosmetic:data Selection.Recursive[0].query.Recursive[0] expand:
        data modify storage cosmetic:data Selection.Recursive[0].query.advancement set from storage cosmetic:data Selection.Recursive[0].query.Recursive[0]
        execute store result score #var var.locked run function ./check_advancement with storage cosmetic:data Selection.Recursive[0].query
    function ./check_advancement:
        $execute unless entity @s[advancements={$(advancement)=true}] run return run data remove storage cosmetic:data Selection.Recursive[0].query
        data remove storage cosmetic:data Selection.Recursive[0].query.Recursive[0]
        execute if data storage cosmetic:data Selection.Recursive[0].query.Recursive[0] expand:
            data modify storage cosmetic:data Selection.Recursive[0].query.advancement set from storage cosmetic:data Selection.Recursive[0].query.Recursive[0]
            function ./check_advancement with storage cosmetic:data Selection.Recursive[0].query
    execute if score #var var.locked matches 1.. run return 1

    return fail

data modify storage cosmetic:data Selection.dialog.actions[-1].equipped set value false
execute if function ./check_equipped run function ./equip_option
function ./check_equipped:
    scoreboard objectives add var.list_size dummy
    scoreboard objectives add var.list_success dummy
    data modify storage player:data test.cosmetics set value []
    data modify storage player:data test.cosmetics append from storage player:data selected.cosmetics[].id
    execute store result score #var var.list_size if data storage player:data test.cosmetics[]
    execute store result score #var var.list_success run data modify storage player:data test.cosmetics[] set from storage cosmetic:data Selection.Recursive[0].id
    execute if score #var var.list_success < #var var.list_size run return 1

    return fail
scoreboard objectives remove var.list_size
scoreboard objectives remove var.list_success
function ./equip_option:
    data modify storage cosmetic:data Selection.dialog.body append value {
        "type": "minecraft:plain_message",
        "contents": {
            "translate": "skill.selection.gui.available_slots",
            "color": "gray",
            "with": [
                {
                    "text": "",
                    "color": "green",
                    "bold": true
                }
            ]
        }
    }
    data modify storage cosmetic:data Selection.dialog.body[-1].contents set value [{"translate": "cosmetic.selection.gui.body.selected","with":[[]],"color":"gray"}]
    data modify storage cosmetic:data Selection.dialog.body[-1].contents[-1].with[0] append value {"translate": "","bold": false}
    data modify storage cosmetic:data Selection.dialog.body[-1].contents[-1].with[0][-1].translate set from storage cosmetic:data Selection.dialog.actions[-1].label.translate
    data modify storage cosmetic:data Selection.dialog.body[-1].contents[-1].with[0][-1].color set from storage cosmetic:data Selection.dialog.actions[-1].label.color
    data modify storage cosmetic:data Selection.dialog.body[-1].contents[-1].with[0][-1].with set from storage cosmetic:data Selection.dialog.actions[-1].label.with

    data modify storage cosmetic:data Selection.dialog.actions[-1].label.color set value "green"
    data modify storage cosmetic:data Selection.dialog.actions[-1].label.with[0].color set value "white"
    data modify storage cosmetic:data Selection.dialog.actions[-1].label.strikethrough set value false
    data modify storage cosmetic:data Selection.dialog.actions[-1].equipped set value true

execute if score #var var.locked matches 1 run function ./lock_option:
    data modify storage cosmetic:data Selection.dialog.actions[-1].label.color set value "dark_gray"
    data modify storage cosmetic:data Selection.dialog.actions[-1].label.with[0].color set value "dark_gray"
    data modify storage cosmetic:data Selection.dialog.actions[-1].action.command set value "trigger cosmetic.selection set -1"
    data modify storage cosmetic:data Selection.dialog.actions[-1].label.strikethrough set value true
    data modify storage cosmetic:data Selection.dialog.actions[-1].equipped set value false
    data modify storage cosmetic:data Selection.dialog.actions[-1].locked set value true
    
    execute if data storage cosmetic:data Selection.Recursive[0].components{"cosmetic:secret": true} run function ./hide_option:
        data modify storage cosmetic:data Selection.dialog.actions[-1].label.color set value "black"
        data modify storage cosmetic:data Selection.dialog.actions[-1].label.with[0].color set value "black"
        data modify storage cosmetic:data Selection.dialog.actions[-1].tooltip[1] set value {"translate": "cosmetic.selection.hidden", "color": "dark_gray", "bold": false}
        data remove storage cosmetic:data Selection.dialog.actions[-1].tooltip[2]
        data modify storage cosmetic:data Selection.dialog.actions[-1].locked set value true

    execute if data storage cosmetic:data Selection.Recursive[0].components."cosmetic:unlockable" run 
        data modify storage cosmetic:data Selection.dialog.actions[-1].tooltip prepend from storage cosmetic:data Selection.Recursive[0].components."cosmetic:unlockable".desc

# Loop function if there are more options to be made
scoreboard objectives remove var.locked
data remove storage cosmetic:data Selection.Recursive[0]
execute if data storage cosmetic:data Selection.Recursive[0] run return run function ~/