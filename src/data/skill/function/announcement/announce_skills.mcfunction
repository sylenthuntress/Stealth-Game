execute if data storage skill:selection KillerSkillsAnnouncement.ran run data remove storage skill:selection KillerSkillsAnnouncement
execute unless data storage skill:selection KillerSkillsAnnouncement run data merge storage skill:selection {KillerSkillsAnnouncement:{"text":{"translate": "skill.announcement.killer_skills", "bold": true, "color": "gold", "with": [[]]}}}

data modify storage skill:data Selection.Recursive set value []
data modify storage skill:data Selection.Recursive append from storage skill:selection RoundSelections[{"team_id": 2}]
execute function ./announce_killer_skills

execute if data storage skill:selection RunnerSkillsAnnouncement.ran run data remove storage skill:selection RunnerSkillsAnnouncement
execute unless data storage skill:selection RunnerSkillsAnnouncement run data merge storage skill:selection {RunnerSkillsAnnouncement:{"text":{"translate": "skill.announcement.runner_skills", "bold": true, "color": "gray", "with": [[]]}}}

data modify storage skill:data Selection.Recursive set value []
data modify storage skill:data Selection.Recursive append from storage skill:selection RoundSelections[{"team_id": 1}]
execute function ./announce_runner_skills

execute as @a run function ./display_personal_skills:
    data remove storage skill:selection SkillDisplay
    data remove storage skill:data Selection.selector
    execute store result storage skill:data Selection.selector.uid int 1 run scoreboard players get @s uid.player   
    data modify storage skill:data Selection.Recursive set value []
    function ./get_personal_skills with storage skill:data Selection.selector