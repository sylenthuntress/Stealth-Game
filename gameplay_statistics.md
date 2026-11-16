## Damage/Health
**Health Scaling**
A runner's HP is an inverse of their kill threshold, compared to their current taken damage. This is equivalent to the formula:
$$
max(50, floor(300 ÷ (floor(totalrunners ÷ 2) + 1) × totalkillers))
$$

**Examples**

| Runner:Killer Ratio | Kill Threshold | Total Percentage |
| ------------------- | -------------- | ---------------- |
| 1:1                 | 300            | 100%             |
| 2:1                 | 150            | 50%              |
| 4:1                 | 75             | 34%              |
| 4:2                 | 200            | 67%              |

**Damage Sources**
1. Note: As player `Health` is normally a float, all taken damage is multiplied by $10$ and stored as an integer for the purposes of damage tracking. 

| Source                         | Damage                                                                                                                           |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------- |
| Base Damage                    | $3.0$                                                                                                                            |
| Trident (Melee)                | $basedamage + 5.0$                                                                                                               |
| Trident (Ranged)               | $8.0$                                                                                                                            |
| Bow Arrow                      | $ceil(2-arrowspeed)$<br>Estimated (0.1s): $1.0$<br>Estimated (0.2 – 0.8s): $5.0$<br>Estimated (0.9): $6.0$                       |
| Bow Arrow<br>(Critical Charge) | Adds a random value between $0$ and:<br>$x = arrowdamage$<br>$(\frac{3x}{2}) + 2$<br>Estimated: $6.0$ – $11.0$<br>Average: $9.0$ |
| Crossbow Arrow                 | $ceil(2-arrowspeed)$<br>Estimated: $9.75$                                                                                        |
| Rat Trap                       | $6.0$                                                                                                                            |
| Environment (e.g cacti)        | Typically $1.0$                                                                                                                  |

## Points
**Point Sources**
1. Note: All points are stored as integers and then divided by $10$ in display (i.e `10` → `1.0`)

| Source                     | Context                                               | \# of Points               | Applicable Teams/Skills       |
| -------------------------- | ----------------------------------------------------- | -------------------------- | ----------------------------- |
| Kill Runner                | Landing the killing blow on a runner                  | $(kill threshold + 5) / 4$ | Killer                        |
| Indirect Kill              | Having a runner die without landing the killing  blow | $(kill threshold+5) / 8$   | Killer                        |
| Attack Runner              | Dealing damage to a runner                            | $(damagedealt+5)/4$        | Killer                        |
| Cross Band                 | Crossing a band after it has already been claimed     | $5$                        | Runner                        |
| Claim Band                 | Crossing a band that has not yet been claimed         | $10$                       | Runner                        |
| Assist Band                | Stunning the killer right before a band is claimed    | $5$                        | Alchemist, Puppeteer, Brawler |
| Stun Killer (Small Puppet) | Having the killer hit a small puppet, and get stunned | $15$                       | Puppeteer                     |
| Stun Killer (Large Puppet) | Having the killer hit a large puppet, and get stunned | $30$                       | Puppeteer                     |
| Cross Finish               | Crossing the finish line during the endgame timer     | $totalsegments × 5$        | Runner                        |
| Cross Finish (First)       | Crossing the finish line before anyone else           | $(totalsegments × 5) - 10$ | Runner                        |
| Assist Finish              | Having a revived runner cross the finish line         | $totalsegments × 5$        | Medic                         |
| Revive Runner              | Reviving a runner                                     | $claimedsegments × 3$      | Medic                         |
**Variables**

| Variable Name     | Explanation                                                                                     |
| ----------------- | ----------------------------------------------------------------------------------------------- |
| $totalsegments$   | The # of segments that have generated                                                           |
| $claimedsegments$ | The # of segments that have been claimed by any runner                                          |
| $damagedealt$     | The # of damage dealt to the target before triggering                                           |
| $killthreshold$   | The # of damage needed before a runner dies (inverted HP)                                       |
| $basedamage$      | The player's `minecraft:attack_damage` attribute<br>(Equivalent to their unarmed attack damage) |
| $totalrunners$    | The # of runners present at the start of the round                                              |
