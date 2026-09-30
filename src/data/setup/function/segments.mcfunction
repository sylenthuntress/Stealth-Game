import level:registry as registry

segments = registry.getSegments()
for segment in segments:
        data modify storage level:registry Registry append value {
            'id': segment, 
            'weight': registry.segments[segment[len(registry.prefix):]].weight, 
            'canBeLarge': registry.segments[segment[len(registry.prefix):]].canBeLarge, 
            'canBeMed': registry.segments[segment[len(registry.prefix):]].canBeMed, 
            'canBeSmall': registry.segments[segment[len(registry.prefix):]].canBeSmall
        }