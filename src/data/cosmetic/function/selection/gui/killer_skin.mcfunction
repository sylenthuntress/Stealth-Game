data modify storage cosmetic:data Selection.dialog set value {
    "type": "minecraft:multi_action",
    "body": [
        {
            "type": "minecraft:plain_message",
            "contents": "\n\n"
        }
    ],
    "inputs": [],
    "after_action": "none",
    "pause": false,
    "can_close_with_escape": true,
    "exit_action": {"label": {"translate": "cosmetic.selection.gui.ready", "color": "green"}, "action": {"type": "minecraft:run_command", "command": "trigger cosmetic.close_selection set 1"}},
    "columns": 1
}
data modify storage cosmetic:data Selection.Recursive set value []
data modify storage cosmetic:data Selection.Recursive append from storage cosmetic:data Registry[{"type": "cosmetic:killer/skin"}]
function player:get/cosmetics
tag @s add cosmetic.selection.killer_skin

data modify storage cosmetic:data Selection.dialog.title set value {"translate": "cosmetic.selection.gui"}

function ./../make_options

function ./../open_dialog
