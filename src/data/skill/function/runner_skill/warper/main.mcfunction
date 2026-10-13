execute unless score @s skill.runner.warper.cooldown matches 100.. at @s run summon minecraft:marker ~ ~ ~ {Tags:["skill.runner.warper.warp_spot"]}
tag @s add this.self
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] unless score @s uid.entity matches 0.. rotated as @a[tag=this.self,limit=1] run rotate @s ~ ~
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] unless score @s uid.entity matches 0.. run scoreboard players operation @s uid.entity = @a[tag=this.self,limit=1] uid.player
execute as @e[type=marker,tag=skill.runner.warper.warp_spot] if score @s uid.entity = @a[tag=this.self,limit=1] uid.player run function skill:runner_skill/warper/tick_warp_spot:
    scoreboard players add @s skill.runner.warper.warp_spot 1
    execute if score @s skill.runner.warper.warp_spot matches 101.. run kill @s
tag @s remove this.self

execute if score @s skill.runner.warper.cooldown matches 1.. run function skill:runner_skill/warper/tick_cooldown:
    scoreboard players remove @s skill.runner.warper.cooldown 1

    scoreboard players operation $display time.display_sec = @s skill.runner.warper.cooldown
    scoreboard players operation $display time.display_sec /= $20 math.const

    item modify entity @s skill:runner_skill/warper/ability skill:runner_skill/warper/disable_ability
    item modify entity @s skill:runner_skill/warper/cooldown skill:runner_skill/warper/set_cooldown

    execute if score @s skill.runner.warper.cooldown matches 0 at @s run function skill:runner_skill/warper/end_cooldown:
        scoreboard players reset @s skill.runner.warper.cooldown
        item modify entity @s skill:runner_skill/warper/cooldown skill:runner_skill/warper/enable_ability
        playsound minecraft:block.end_portal_frame.fill player @s ~ ~ ~ 1 1