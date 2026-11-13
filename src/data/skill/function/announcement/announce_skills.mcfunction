execute if data storage skill:data KillerSkillsAnnouncement.ran run data remove storage skill:data KillerSkillsAnnouncement
execute unless data storage skill:data KillerSkillsAnnouncement run data merge storage skill:data {KillerSkillsAnnouncement:{"text":{"translate": "skill.announcement.killers", "bold": true, "color": "gold", "with": [[]]}}}

data modify storage skill:data Selection.Recursive set value []
data modify storage skill:data Selection.Recursive append from storage skill:data Selection.RoundSelections[{"team_id": 2}]
execute function ./announce_killer_skills

execute if data storage skill:data RunnerSkillsAnnouncement.ran run data remove storage skill:data RunnerSkillsAnnouncement
execute unless data storage skill:data RunnerSkillsAnnouncement run data merge storage skill:data {RunnerSkillsAnnouncement:{"text":{"translate": "skill.announcement.runners", "bold": true, "color": "gray", "with": [[]]}}}

data modify storage skill:data Selection.Recursive set value []
data modify storage skill:data Selection.Recursive append from storage skill:data Selection.RoundSelections[{"team_id": 1}]
execute function ./announce_runner_skills

execute as @a run function ./display_personal_skills:
    data remove storage skill:data SkillDisplay
    data remove storage skill:data Selection.selector
    execute store result storage skill:data Selection.selector.uid int 1 run scoreboard players get @s uid   
    data modify storage skill:data Selection.Recursive set value []
    function ./get_personal_skills with storage skill:data Selection.selector