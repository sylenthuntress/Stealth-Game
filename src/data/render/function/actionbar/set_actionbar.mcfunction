## {duration: int, text: Text}
function player:prepare_store
$data modify storage player:data players[-1].actionbar.duration set value $(duration)
data modify storage player:data players[-1].actionbar.text set value [" "]
$data modify storage player:data players[-1].actionbar.text append value $(text)