data remove storage skill:selection Options
data remove storage skill:selection Recursive
data modify storage skill:selection Recursive set from storage skill:registry WeaponRegistry
tag @s add skill.selection.weapon
function skill:selection/make_options

data merge storage skill:selection {"title": {"translate": "skill.selection.gui.weapon"}}

scoreboard players reset @s skill.switch_selection
scoreboard players enable @s skill.switch_selection
data modify storage skill:selection Options insert 1 value {
    "label": {
        "translate": "skill.selection.gui",
        "color": "gray",
        "bold": true,
        "underlined": true
    },
    "width": 140,
    "action": {
        "type": "minecraft:run_command",
        "command": "trigger skill.switch_selection set 2"
    }
}

function skill:selection/open_dialog with storage skill:selection
