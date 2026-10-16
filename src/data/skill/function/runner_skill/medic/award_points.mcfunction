tag @s add this.self
execute as @a[tag=playing] if score @s uid.player = @p[tag=this.self] skill.runner.medic.revive_uid run tag @s add this.medic
tag @s remove this.self

scoreboard players add @a[tag=this.medic] game.player.due_points 25
tellraw @a {"translate": "skill.runner.medic.cross_finish", "color": "red", with:[{"selector":"@a[tag=this.medic]"}]}

tag @a remove this.medic