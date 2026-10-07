data remove storage skill:selection Recursive
data modify storage skill:selection Recursive append from storage skill:registry RunnerSkills[]
data modify storage skill:selection Recursive append from storage skill:registry KillerSkills[]
data modify storage skill:selection Recursive append from storage skill:registry WeaponRegistry[]

function skill:remove_tags with storage skill:selection Recursive[0]
