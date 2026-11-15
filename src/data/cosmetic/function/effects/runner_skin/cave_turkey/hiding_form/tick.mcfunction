append function_tag skill:runner/puppeteer/fake_cosmetic: {
  "values": [(~/)]
}
append function_tag event:tick/hiding: {
  "values": [(~/)]
}

execute unless entity @s[tag=hiding] run return fail
execute unless entity @s[tag=cosmetic.runner_skin.cave_turkey] run return fail

tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid.hiding_form = @n[tag=this.self] uid.hiding_form run tag @s add this.display

execute as @n[type=item_display,tag=this.display] as @s[distance=0.125..] facing entity @s eyes run function ./sync_walking:
    function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/walking/resume
    execute as @s[distance=..0.124] run return 1

    function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/walking/next_frame
    execute positioned ^ ^ ^.1 run function ~/
execute as @n[type=item_display,tag=this.display] as @s[distance=..0.124] if score @s animation.cosmetic.runner_skin.cave_turkey.hiding_form.walking.frame matches 1.. run function ./stop_walking:
    execute if score @s animation.cosmetic.runner_skin.cave_turkey.hiding_form.walking.frame matches ..5 run function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/walking/apply_frame {frame: 6}
    execute if score @s animation.cosmetic.runner_skin.cave_turkey.hiding_form.walking.frame matches 7.. run function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/walking/apply_frame {frame: 13}
    function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/walking/pause
    function animation:cosmetic/runner_skin/cave_turkey/hiding_form/apply_default_pose

execute unless score @s cosmetic.runner_skin.cave_turkey.hurt_timer matches 1.. if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:flags":{is_on_ground:1b}}} 
    as @n[type=item_display,tag=this.display] if score @s animation.cosmetic.runner_skin.cave_turkey.hiding_form.flapping.frame matches 1.. 
        run function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/flapping/apply_frame {frame: 0}
execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:flags":{is_on_ground:0b}}} 
    as @n[type=item_display,tag=this.display] run function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/flapping/resume
execute if score @s cosmetic.runner_skin.cave_turkey.hurt_timer matches 1.. expand:
    execute as @n[type=item_display,tag=this.display] run function animation:cosmetic/runner_skin/cave_turkey/hiding_form/animations/flapping/resume
tag @e remove this.display
tag @s remove this.self