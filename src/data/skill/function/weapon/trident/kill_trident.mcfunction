execute on origin run tag @s add this.selected
execute if entity @a[tag=this.selected,tag=this.selector] run kill @s
tag @a remove this.selected