data modify storage cosmetic:data Selection.dialog set value {
    "type": "minecraft:multi_action",
    "body": {
        "type": "minecraft:plain_message",
        "contents": "\n\n"
    },
    "inputs": [],
    "pause": false,
    "after_action": "none",
    "can_close_with_escape": true,
    "exit_action": {"label": {"translate": "cosmetic.selection.gui.ready", "color": "green"}, "action": {"type": "minecraft:run_command", "command": "trigger cosmetic.close_selection set 1"}},
    "columns": 1
}
data modify storage cosmetic:data Selection.Recursive set value []
data modify storage cosmetic:data Selection.Recursive append from storage cosmetic:data Registry[{"type": "cosmetic:runner/skin"}]
function player:get/cosmetics
tag @s add cosmetic.selection.runner_skin

data modify storage cosmetic:data Selection.dialog.title set value {"translate": "cosmetic.selection.gui"}

function ./../make_options

function ./../open_dialog
