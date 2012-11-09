varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	
	//grey scale
	float luminance  = dot(texture2D(u_image, v_Texcoords).rgb,  vec3(0.2125, 0.7154, 0.0721)); 
	gl_FragColor = vec4(luminance ,luminance , luminance, 1.0);
	
}
