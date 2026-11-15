append function_tag skill:runner/puppeteer/fake_cosmetic: {
  "values": [(~/)]
}
append function_tag event:tick/hiding: {
  "values": [(~/)]
}

execute unless entity @s[tag=hiding] run return fail
execute unless entity @s[tag=cosmetic.runner_skin.allay] run return fail

tag @s add this.self
execute as @e[type=item_display,tag=hiding_form] if score @s uid.hiding_form = @n[tag=this.self] uid.hiding_form run tag @s add this.display

execute as @n[type=item_display,tag=this.display] as @s[distance=0.125..] run function ./anim/move:
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/pause
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/move/resume
execute as @n[type=item_display,tag=this.display] as @s[distance=..0.124] run function ./anim/idle:
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/move/pause
    function animation:cosmetic/runner_skin/allay/hiding_form/animations/idle/resume

tag @e remove this.display
tag @s remove this.self