function player:get/cosmetics
execute at @s if function #~/ run return run data remove storage event:data context.stop_hiding

data remove storage event:data context.stop_hiding
return fail