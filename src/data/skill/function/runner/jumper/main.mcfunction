advancement ~/ {
  "criteria": {
    "requirement": {
      "trigger": "minecraft:tick",
      "conditions": {
        "player": {
          "type": "minecraft:entity_properties",
          "entity": "this",
          "predicate": {
            "minecraft:entity_tags": {
              "any_of": [
                "skill.runner.jumper"
              ]
            }
          }
        }
      }
    }
  },
  "rewards": {
    "function": (~/)
  }
}

advancement revoke @s only ~/

maxCharge = 7
chargeCooldown = 12
chargeMult = 3
green = (0, 255, 0)
def hexify(num):
    return f"{num:02x}"

def hexify_tuple(tup):
    string = ''
    for value in tup:
        string += ''.join(hexify(value))
    return '#' + string

for n in range(1, maxCharge+1):
    new_green = (green[0], int(green[1] * (1 - n/maxCharge/2)), green[2])
    execute if score @s skill.runner.jumper.charge matches n function render:actionbar/set_actionbar {duration:2, text:{
        "color": "gold",
        "bold": true,
        "italic": false,
        "translate": "skill.cooldown",
        "with": [
           [ {
                "score": {
                    "name": "@s",
                    "objective": "skill.runner.jumper.charge"
                },
                "bold": true,
                "color": hexify_tuple(new_green)
            },
            {
				"text": "/",
				"bold": false
            },
            {
				"text": str(maxCharge),
				"color": hexify_tuple((green[0], int(green[1]/2), green[2])),
				"bold": false
            }]
        ]
    }}

execute unless predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:flags":{is_on_ground:1b}}} run item modify entity @s
  {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.*"},item_filter:{predicates:{"minecraft:custom_data":{skill.runner.jumper.ability:1b}}}}
  {type:"minecraft:set_name",name:{
        "color": "dark_gray",
        "translate": "skill.runner.jumper.disabled",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:mob_effect/jump_boost",
                "atlas": "minecraft:gui",
                "color": "white"
            }
        ]
    }}
execute if predicate {type:"minecraft:entity_properties",entity:"this",predicate:{"minecraft:flags":{is_on_ground:1b}}} run item modify entity @s
  {type:"minecraft:filtered",slot_source:{type:"minecraft:slot_range",slots:"hotbar.*"},item_filter:{predicates:{"minecraft:custom_data":{skill.runner.jumper.ability:1b}}}}
  {type:"minecraft:set_name",name:{
        "color": "#7ca132",
        "translate": "skill.runner.jumper.ability",
        "italic": false,
        "with": [
            {
                "sprite": "minecraft:mob_effect/jump_boost",
                "atlas": "minecraft:gui",
                "color": "white"
            },
            {
                "translate": "skill.use",
                "color": "#759953"
            }
        ]
    }}