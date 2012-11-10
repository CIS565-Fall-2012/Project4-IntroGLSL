varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec3 temp = texture2D(u_image, v_Texcoords).rgb;
	const vec3 W = vec3(0.2125, 0.7154, 0.0721);
	float luminance = dot(temp.rgb, W);
	
	if(luminance > 0.9)
		luminance = 1.0;
	else
		luminance = 0.0;

	gl_FragColor = vec4(vec3(luminance * temp.rgb), 1.0);
}
