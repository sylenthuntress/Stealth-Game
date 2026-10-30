data modify storage skill:data Selection.dialog set value {
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
}
data modify storage skill:data Selection.Recursive set value []
data modify storage skill:data Selection.Recursive append from storage skill:data Registry[{"type": "skill:killer"}]
advancement revoke @s only skill:selection/killer_gui
tag @s add skill.selection.killer_skill
function skill:selection/make_options

data modify storage skill:data Selection.dialog.title set value {"translate": "skill.selection.gui"}

scoreboard players reset @s skill.switch_selection
scoreboard players enable @s skill.switch_selection
data modify storage skill:data Selection.dialog.actions insert 1 value {
    "label": {
        "translate": "skill.selection.gui.weapon",
        "color": "white",
        "bold": true,
        "underlined": true
    },
    "width": 140,
    "action": {
        "type": "minecraft:run_command",
        "command": "trigger skill.switch_selection set 1"
    }
}

function skill:selection/open_dialog