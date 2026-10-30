data remove storage skill:data Selection.Recursive[0].skills[{"type": "skill:runner"}] # Hide runner skills from display
data remove storage skill:data Selection.Recursive[0].skills[{"random_skill": true}] # Hide random skills from display

# Make the text components based on each skill (i.e [Athlete/Trapper])
execute unless data storage skill:selection KillerSkillsAnnouncement.text.with[0][-1] run data modify storage skill:selection KillerSkillsAnnouncement.text.with[0] append value {"text": "\n- [","color":"#712525", "bold": false, "hover_event":{"action": "show_text","value":[{"text": ""}]}}

data modify storage skill:selection KillerSkillsAnnouncement.text.with[0] append value {"translate": "", "color": "gold", "bold": false, "with": [{"sprite": "", "atlas": ""}], "hover_event": {"action": "show_text","value":[{"translate": ""}]}}
data modify storage skill:selection KillerSkillsAnnouncement.text.with[0][-1]."translate" set from storage skill:data Selection.Recursive[0].skills[0].id
data modify storage skill:selection KillerSkillsAnnouncement.text.with[0][-1]."with"[0]."color" set value "white"
data modify storage skill:selection KillerSkillsAnnouncement.text.with[0][-1]."with"[0]."sprite" set from storage skill:data Selection.Recursive[0].skills[0].icon.sprite
data modify storage skill:selection KillerSkillsAnnouncement.text.with[0][-1]."with"[0]."atlas" set from storage skill:data Selection.Recursive[0].skills[0].icon.atlas
data modify storage skill:selection KillerSkillsAnnouncement.text.with[0][-1]."hover_event"."value"[0] set from storage skill:data Selection.Recursive[0].skills[0].desc
execute unless data storage skill:data Selection.Recursive[0].skills[0] run data modify storage skill:selection KillerSkillsAnnouncement.text.with[0][-1] set value {"text": "None", "color": "gold"}

# Loop function until all skills have been sorted
execute if data storage skill:data Selection.Recursive[0].skills[1]."killer_skill" expand:
    data modify storage skill:selection KillerSkillsAnnouncement.text.with[0] append value {"text": "/","hover_event":{"action": "show_text","value":[{"text": ""}]}}

execute if data storage skill:data Selection.Recursive[0].skills[1]."weapon" expand:
    execute if data storage skill:data Selection.Recursive[0].skills[0]."killer_skill" run data modify storage skill:selection KillerSkillsAnnouncement.text.with[0] append value {"text": "], [","color":"#712525","hover_event":{"action": "show_text","value":[{"text": ""}]}}
    execute if data storage skill:data Selection.Recursive[0].skills[0]."weapon" run data modify storage skill:selection KillerSkillsAnnouncement.text.with[0] append value {"text": "/","hover_event":{"action": "show_text","value":[{"text": ""}]}}

data remove storage skill:data Selection.Recursive[0].skills[0]
execute if data storage skill:data Selection.Recursive[0].skills[0] run return run function ~/
execute if data storage skill:selection KillerSkillsAnnouncement.text.with[0][0] run data modify storage skill:selection KillerSkillsAnnouncement.text.with[0] append value {"text": "]","color":"#712525","hover_event":{"action": "show_text","value":[{"text": ""}]}}

# Loop function with next player's skills, until all players have been sorted
data remove storage skill:data Selection.Recursive[0]
execute if data storage skill:data Selection.Recursive[0] expand:
    data modify storage skill:selection KillerSkillsAnnouncement.text.with[0] append value {"text": "\n- [","hover_event":{"action": "show_text","value":[{"text": ""}]}}
    return run function ~/

# Display tellraw and end function
function util:tellraw_players with storage skill:selection KillerSkillsAnnouncement
data modify storage skill:selection KillerSkillsAnnouncement.ran set value true
scoreboard players reset #var game.player.team_id