shader_type spatial;

uniform sampler2D HeightMap;
uniform float HeightScale;

void vertex()
{
	VERTEX.y += texture(HeightMap,UV).r * HeightScale ;
	
}