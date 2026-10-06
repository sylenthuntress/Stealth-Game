import level:registry as level_registry
import skill:registry as skill_registry

# Level Generation
data remove storage level:registry SegmentRegistry
data remove storage level:registry BandRegistry

segments = level_registry.getSegments()
for segment in segments:
        data modify storage level:registry SegmentRegistry append value {
            'id': segment, 
            'weight': level_registry.segments[segment[len(level_registry.segment_prefix):]].weight,
            'biome': level_registry.segments[segment[len(level_registry.segment_prefix):]].biome
        }
        canBeLarge = level_registry.segments[segment[len(level_registry.segment_prefix):]].canBeLarge
        canBeMed = level_registry.segments[segment[len(level_registry.segment_prefix):]].canBeMed
        canBeSmall = level_registry.segments[segment[len(level_registry.segment_prefix):]].canBeSmall
        if canBeLarge == 1:
            data modify storage level:registry SegmentRegistry[-1].canBeLarge set value canBeLarge
        if canBeMed == 1:
            data modify storage level:registry SegmentRegistry[-1].canBeMed set value canBeMed
        if canBeSmall == 1:
            data modify storage level:registry SegmentRegistry[-1].canBeSmall set value canBeSmall

bands = level_registry.getBands()
for band in bands:
        data modify storage level:registry BandRegistry append value {
            'id': band, 
            'weight': level_registry.bands[band[len(level_registry.band_prefix):]].weight
        }
        canBeLarge = level_registry.bands[band[len(level_registry.band_prefix):]].canBeLarge
        canBeMed = level_registry.bands[band[len(level_registry.band_prefix):]].canBeMed
        canBeSmall = level_registry.bands[band[len(level_registry.band_prefix):]].canBeSmall
        if canBeLarge == 1:
            data modify storage level:registry BandRegistry[-1].canBeLarge set value canBeLarge
        if canBeMed == 1:
            data modify storage level:registry BandRegistry[-1].canBeMed set value canBeMed
        if canBeSmall == 1:
            data modify storage level:registry BandRegistry[-1].canBeSmall set value canBeSmall

# Skills
data remove storage skill:registry RunnerSkills
data remove storage skill:registry KillerSkills
data remove storage skill:registry WeaponRegistry

runner_skills = skill_registry.getRunnerSkills()
for runner_skill in runner_skills:
    data modify storage skill:registry RunnerSkills append value {
        'id': runner_skill,
        'desc': (runner_skill + ".desc"),
        'numid': skill_registry.runner_skills[runner_skill[len(skill_registry.runner_prefix):]].id,
        'icon': skill_registry.runner_skills[runner_skill[len(skill_registry.runner_prefix):]].icon,
        'atlas': skill_registry.runner_skills[runner_skill[len(skill_registry.runner_prefix):]].atlas
    }

killer_skills = skill_registry.getKillerSkills()
for killer_skill in killer_skills:
    data modify storage skill:registry KillerSkills append value {
        'id': killer_skill,
        'desc': (killer_skill + ".desc"),
        'numid': skill_registry.killer_skills[killer_skill[len(skill_registry.killer_prefix):]].id,
        'icon': skill_registry.killer_skills[killer_skill[len(skill_registry.killer_prefix):]].icon,
        'atlas': skill_registry.killer_skills[killer_skill[len(skill_registry.killer_prefix):]].atlas
    }

weapons = skill_registry.getWeapons()
for weapon in weapons:
    data modify storage skill:registry WeaponRegistry append value {
        'id': weapon,
        'desc': (weapon + ".desc"),
        'numid': skill_registry.weapons[weapon[len(skill_registry.weapon_prefix):]].id,
        'icon': skill_registry.weapons[weapon[len(skill_registry.weapon_prefix):]].icon,
        'atlas': skill_registry.weapons[weapon[len(skill_registry.weapon_prefix):]].atlas
    }

    
# Compatibility with other datapacks
function #setup:registries