import level:registry as registry

data remove storage level:registry SegmentRegistry
data remove storage level:registry BandRegistry

segments = registry.getSegments()
for segment in segments:
        data modify storage level:registry SegmentRegistry append value {
            'id': segment, 
            'weight': registry.segments[segment[len(registry.segment_prefix):]].weight,
            'biome': registry.segments[segment[len(registry.segment_prefix):]].biome,
            'canBeLarge': registry.segments[segment[len(registry.segment_prefix):]].canBeLarge, 
            'canBeMed': registry.segments[segment[len(registry.segment_prefix):]].canBeMed, 
            'canBeSmall': registry.segments[segment[len(registry.segment_prefix):]].canBeSmall
        }

bands = registry.getBands()
for band in bands:
        data modify storage level:registry BandRegistry append value {
            'id': band, 
            'weight': registry.bands[band[len(registry.band_prefix):]].weight, 
            'canBeLarge': registry.bands[band[len(registry.band_prefix):]].canBeLarge, 
            'canBeMed': registry.bands[band[len(registry.band_prefix):]].canBeMed, 
            'canBeSmall': registry.bands[band[len(registry.band_prefix):]].canBeSmall
        }
    
function #setup:registries # Compatibility with other datapacks