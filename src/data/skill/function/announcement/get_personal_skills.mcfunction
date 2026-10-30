$execute unless data storage skill:data Selection.Recursive[0] run data modify storage skill:data Selection.Recursive append from storage skill:selection RoundSelections[{"uid": $(uid)}] 
data remove storage skill:data Selection.Recursive[0].skills[{"components":{"skill:random": true}}] # Hide random from display

execute unless data storage skill:selection SkillDisplay.text.with[0][-1] if score @s game.player.team_id matches 1 run data merge storage skill:selection {SkillDisplay:{"text":{"translate": "skill.personal", "bold": true, "color": "dark_gray", "with": [[]]}}}
execute unless data storage skill:selection SkillDisplay.text.with[0][-1] if score @s game.player.team_id matches 2 run data merge storage skill:selection {SkillDisplay:{"text":{"translate": "skill.personal", "bold": true, "color": "#712525", "with": [[]]}}}

execute if score @s game.player.team_id matches 1 unless data storage skill:selection SkillDisplay.text.with[0][0] run data modify storage skill:selection SkillDisplay.text.with[0] append value {"text": "[","color":"dark_gray","hover_event":{"action": "show_text","value":[{"text": ""}]}}
execute if score @s game.player.team_id matches 2 unless data storage skill:selection SkillDisplay.text.with[0][0] run data modify storage skill:selection SkillDisplay.text.with[0] append value {"text": "[","color":"#712525","hover_event":{"action": "show_text","value":[{"text": ""}]}}
execute if score @s game.player.team_id matches 1 data modify storage skill:selection SkillDisplay.text.with[0] append value {"translate": "", "color": "gray", "with": [{"sprite": "", "atlas": ""}], "hover_event": {"action": "show_text","value":[{"translate": ""}]}}
execute if score @s game.player.team_id matches 2 run data modify storage skill:selection SkillDisplay.text.with[0] append value {"translate": "", "color": "gold", "with": [{"sprite": "", "atlas": ""}], "hover_event": {"action": "show_text","value":[{"translate": ""}]}}
data modify storage skill:selection SkillDisplay.text.with[0][-1]."translate" set from storage skill:data Selection.Recursive[0].skills[0].id
data modify storage skill:selection SkillDisplay.text.with[0][-1]."with"[0]."color" set value "white"
data modify storage skill:selection SkillDisplay.text.with[0][-1]."with"[0]."sprite" set from storage skill:data Selection.Recursive[0].skills[0].icon.sprite
data modify storage skill:selection SkillDisplay.text.with[0][-1]."with"[0]."atlas" set from storage skill:data Selection.Recursive[0].skills[0].icon.atlas
data modify storage skill:selection SkillDisplay.text.with[0][-1]."hover_event"."value"[0] set from storage skill:data Selection.Recursive[0].skills[0].desc

execute if data storage skill:data Selection.Recursive[0].skills[1] unless data storage skill:data Selection.Recursive[0].skills[1]."weapon" expand:
    data modify storage skill:selection SkillDisplay.text.with[0] append value {"text": "/","hover_event":{"action": "show_text","value":[{"text": ""}]}}

execute if data storage skill:data Selection.Recursive[0].skills[1]."weapon" expand:
    execute unless data storage skill:data Selection.Recursive[0].skills[0]."weapon" run data modify storage skill:selection SkillDisplay.text.with[0] append value {"text": "], [","color":"#712525","hover_event":{"action": "show_text","value":[{"text": ""}]}}
    execute if data storage skill:data Selection.Recursive[0].skills[0]."weapon" run data modify storage skill:selection SkillDisplay.text.with[0] append value {"text": "/","hover_event":{"action": "show_text","value":[{"text": ""}]}}
data remove storage skill:data Selection.Recursive[0].skills[0]
execute if data storage skill:data Selection.Recursive[0].skills[0] run return run function ~/ with storage skill:data Selection.selector

execute if score @s game.player.team_id matches 1 run data modify storage skill:selection SkillDisplay.text.with[0] append value {"text": "]","color":"dark_gray","hover_event":{"action": "show_text","value":[{"text": ""}]}}
execute if score @s game.player.team_id matches 2 run data modify storage skill:selection SkillDisplay.text.with[0] append value {"text": "]","color":"#712525","hover_event":{"action": "show_text","value":[{"text": ""}]}}

function util:tellraw_self with storage skill:selection SkillDisplay