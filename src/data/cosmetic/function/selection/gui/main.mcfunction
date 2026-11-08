data modify storage cosmetic:data Selection.dialog set value {
    "type": "minecraft:multi_action",
    "body": {
        "type": "minecraft:plain_message",
        "contents": "\n\n"
    },
    "inputs": [],
    "actions": [
        {
            "label": {
                "translate": "cosmetic.selection.runner_skin"
            },
            "action": {
                "type": "minecraft:run_command",
                "command": "trigger cosmetic.switch_gui set 1"
            }
        },
        {
            "label": {
                "translate": "cosmetic.selection.killer_skin"
            },
            "action": {
                "type": "minecraft:run_command",
                "command": "trigger cosmetic.switch_gui set 2"
            }
        }
    ],
    "pause": false,
    "after_action": "none",
    "can_close_with_escape": true,
    "exit_action": {"label": {"translate": "cosmetic.selection.gui.ready", "color": "green"}, "action": {"type": "minecraft:run_command", "command": "trigger cosmetic.close_selection set 1"}},
    "columns": 2
}
tag @s add cosmetic.selection.main

data modify storage cosmetic:data Selection.dialog.title set value {"translate": "cosmetic.selection.gui"}

scoreboard players enable @s cosmetic.switch_gui
scoreboard players enable @s cosmetic.close_selection
function util:show_dialog with storage cosmetic:data Selection