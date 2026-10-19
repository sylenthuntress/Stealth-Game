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
data modify storage skill:selection Recursive set from storage skill:registry RunnerSkills
advancement revoke @s only skill:selection/runner_gui
tag @s add skill.selection.runner_skill

data modify storage skill:selection dialog.title set value {"translate": "skill.selection.gui"}

function skill:selection/make_options

function skill:selection/open_dialog
