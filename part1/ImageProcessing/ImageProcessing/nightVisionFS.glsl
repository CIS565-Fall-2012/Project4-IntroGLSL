varying vec2 v_Texcoords;

uniform sampler2D u_image;

const vec3 green = vec3(0.0, 1.0, 0.0);

// Reference: rasterizeKernels.cu by Yining Karl Li in Project3
uint hash(uint a){
    a = (a+0x7ed55d16) + (a<<12);
    a = (a^0xc761c23c) ^ (a>>19);
    a = (a+0x165667b1) + (a<<5);
    a = (a+0xd3a2646c) ^ (a<<9);
    a = (a+0xfd7046c5) + (a<<3);
    a = (a^0xb55a4f09) ^ (a>>16);
    return a;
}

// Reference: http://freespace.virgin.net/hugo.elias/models/m_perlin.htm
float noiseFloat1(uint x)			 
{
    x = (x<<13) ^ x;
    return ( 1.0 - ( (x * (x * x * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0);
}


void main(void)
{
	const vec4 originRBGA = texture2D(u_image, v_Texcoords);
	uint randSeed = hash(floatBitsToUint(v_Texcoords.s)) + hash(floatBitsToUint(v_Texcoords.t));

	float noiseColor = (noiseFloat1(randSeed) + 1) * 0.5;

	if (length(vec2(v_Texcoords.s - 0.5, v_Texcoords.t - 0.5)) >= 0.5) {
		gl_FragColor.rgb = vec3(0.0);
	} else {
		gl_FragColor.rgb = green * (originRBGA.rgb + vec3(noiseColor)) * 0.5;
	}
	gl_FragColor.a =originRBGA.a;
}
