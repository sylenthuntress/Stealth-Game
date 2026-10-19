data merge storage skill:selection {dialog:{
    "type": "minecraft:multi_action",
    "body": {
        "type": "minecraft:plain_message",
        "contents": "\n\n"
    },
    "inputs": [],
    "pause": false,
    "can_close_with_escape": true,
    "exit_action": {"label": {"translate": "skill.selection.gui.ready", "color": "green"}, "action": {"type": "minecraft:run_command", "command": "trigger skill.close_selection set 1"}},
    "columns": 3
}}
data modify storage skill:selection Recursive set from storage skill:registry WeaponRegistry
tag @s add skill.selection.weapon
function skill:selection/make_options

data modify storage skill:selection dialog.title set value {"translate": "skill.selection.gui.weapon"}

scoreboard players reset @s skill.switch_selection
scoreboard players enable @s skill.switch_selection
data modify storage skill:selection dialog.actions insert 1 value {
    "label": {
        "translate": "skill.selection.gui",
        "color": "white",
        "bold": true,
        "underlined": true
    },
    "width": 140,
    "action": {
        "type": "minecraft:run_command",
        "command": "trigger skill.switch_selection set 2"
    }
}

function skill:selection/open_dialog