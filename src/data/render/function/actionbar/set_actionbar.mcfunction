## {duration: int, text: Text}
data remove storage actionbar:data selector
execute store result storage actionbar:data selector.uid int 1 run scoreboard players get @s uid.player
$data modify storage actionbar:data selector.duration set value $(duration)
$data modify storage actionbar:data selector.text set value $(text)
function ./make_new with storage actionbar:data selector
function ./make_new:
    $data modify storage actionbar:data players[{uid:$(uid)}].duration set value $(duration)
    $data modify storage actionbar:data players[{uid:$(uid)}].text set value $(text)