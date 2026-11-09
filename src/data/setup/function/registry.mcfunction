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
    
# Compatibility with other datapacks
function #setup:registries