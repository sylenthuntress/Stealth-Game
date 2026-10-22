data remove storage skill:selection Recursive[0].skills[{"random_skill": true}] # Hide random skills from display
data remove storage skill:selection Recursive[0].skills[{"killer_skill": true}] # Hide killer skills from display
data remove storage skill:selection Recursive[0].skills[{"weapon": true}] # Hide weapons from display

# Make the text components based on each skill (i.e [Camouflage/Brawler])
execute unless data storage skill:selection RunnerSkillsAnnouncement.text.with[0][-1] run data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0] append value {"text": "\n- [","color":"dark_gray", "bold": false, "hover_event":{"action": "show_text","value":[{"text": ""}]}}

data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0] append value {"translate": "", "color": "gray", "with": [{"sprite": "", "atlas": ""}], "hover_event": {"action": "show_text","value":[{"translate": ""}]}}
data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0][-1]."translate" set from storage skill:selection Recursive[0].skills[0].id
data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0][-1]."with"[0]."color" set value "white"
data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0][-1]."with"[0]."sprite" set from storage skill:selection Recursive[0].skills[0].icon
data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0][-1]."with"[0]."atlas" set from storage skill:selection Recursive[0].skills[0].atlas
data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0][-1]."hover_event"."value"[0]."translate" set from storage skill:selection Recursive[0].skills[0].desc
execute unless data storage skill:selection Recursive[0].skills[0] run data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0][-1] set value {"text": "None", "bold": false, "color": "gray"}

# Loop function until all skills have been sorted
data remove storage skill:selection Recursive[0].skills[0]
execute if data storage skill:selection Recursive[0].skills[0] expand:
    data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0] append value {"text": "/","hover_event":{"action": "show_text","value":[{"text": ""}]}}
    return run function ~/

execute if data storage skill:selection RunnerSkillsAnnouncement.text.with[0][0] run data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0] append value {"text": "]","color":"dark_gray","hover_event":{"action": "show_text","value":[{"text": ""}]}}

# Loop function with next player's skills, until all players have been sorted
data remove storage skill:selection Recursive[0]
execute store result score #var game.player.team_id run data get storage skill:selection Recursive[0].team_id
execute if data storage skill:selection Recursive[0] expand:
    data modify storage skill:selection RunnerSkillsAnnouncement.text.with[0] append value {"text": "\n- [","hover_event":{"action": "show_text","value":[{"text": ""}]}}
    return run function ~/

# Display tellraw and end function
function util:tellraw_players with storage skill:selection RunnerSkillsAnnouncement
data modify storage skill:selection RunnerSkillsAnnouncement.ran set value true
scoreboard players reset #var game.player.team_id