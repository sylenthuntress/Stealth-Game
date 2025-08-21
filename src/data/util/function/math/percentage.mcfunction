# Throw error if operator/operand not present
execute unless score $operand math.percentage matches -2147483648..2147483647 run say Operand for "percentage" calculation not found
execute unless score $operator math.percentage matches -2147483648..2147483647 run say Operator for "percentage" calculation not found

execute unless score $operand math.percentage matches -2147483648..2147483647 run return fail
execute unless score $operator math.percentage matches -2147483648..2147483647 run return fail

# Calculations
scoreboard players operation $operand math.percentage *= #CONSTANT constant.100

scoreboard players operation $operand math.percentage /= $operator math.percentage
scoreboard players operation $result math.result = $operand math.percentage

# Reset operator/operand after calculation
scoreboard players reset $operand math.percentage
scoreboard players reset $operator math.percentage

# Return result
return run scoreboard players get $result math.result