# Throw error if operator/operand not present
execute unless score $operand math.division matches -2147483648..2147483647 run say Operand for "division" calculation not found
execute unless score $operator math.division matches -2147483648..2147483647 run say Operator for "division" calculation not found

execute unless score $operand math.division matches -2147483648..2147483647 run return fail
execute unless score $operator math.division matches -2147483648..2147483647 run return fail

# Calculations
scoreboard players operation $operand math.division /= $operator math.division
scoreboard players operation $result math.result = $operand math.division

# Reset operator/operand after calculation
scoreboard players reset $operand math.division
scoreboard players reset $operator math.division

# Return result
return run scoreboard players get $result math.result