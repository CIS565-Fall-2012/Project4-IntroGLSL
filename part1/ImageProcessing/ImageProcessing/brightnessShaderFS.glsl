varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
	//float mu = pow((rgb.r + rgb.g + rgb.b), 2.0) /9.0;
	float mu = (rgb.r + rgb.g + rgb.b) / 3.0;
	gl_FragColor = vec4(vec3(rgb * mu), 1.0);
}
