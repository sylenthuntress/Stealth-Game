execute store result storage skill:data RunnerSkill.Medic.selector.revived_uid int 1 run scoreboard players get @s uid.player
execute as @a[tag=game.playing] run function ~/find_medics:
    execute store result storage skill:data RunnerSkill.Medic.selector.medic_uid int 1 run scoreboard players get @s uid.player
    function ~/check_storage with storage skill:data RunnerSkill.Medic.selector
    function ./check_storage:
        $execute if data storage skill:data RunnerSkill.Medic.revival_credit.$(revived_uid){"$(medic_uid)": true} run tag @s add this.medic

scoreboard players operation #math game.player.due_points = #segments segments.elapsed
scoreboard players operation #math game.player.due_points *= #5 math.const
scoreboard players operation @a[tag=this.medic] game.player.due_points += #math game.player.due_points
tellraw @a[tag=game.viewing] {"translate": "skill.runner.medic.cross_finish", "color": "red", with:[{"selector":"@s"},{"selector":"@a[tag=this.medic]"}]}

tag @a remove this.medic