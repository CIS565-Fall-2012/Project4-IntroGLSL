varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{	
	const vec3 sepia = vec3(0.3625, 0.1494, 0.0701);
	float weight=0.23;
	vec3 luminance = texture2D(u_image, v_Texcoords)*(1.0 -weight) + sepia*(1.0 - weight);
	gl_FragColor =  vec4(luminance,1);
	//gl_FragColor = vec3(1.0f)-texture2D(u_image, v_Texcoords);
}
