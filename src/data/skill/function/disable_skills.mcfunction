data remove storage skill:selection selector
execute store result storage skill:selection selector.uid int 1 run scoreboard players get @s uid.player

data remove storage skill:selection Recursive
data modify storage skill:selection Recursive append from storage skill:registry RunnerSkills[]
data modify storage skill:selection Recursive append from storage skill:registry KillerSkills[]
data modify storage skill:selection Recursive append from storage skill:registry WeaponRegistry[]

function skill:remove_tags with storage skill:selection Recursive[0]
