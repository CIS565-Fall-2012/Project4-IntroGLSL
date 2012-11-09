varying vec2 v_Texcoords;
uniform sampler2D u_image;

void main(void)
{

	 vec3 color = texture2D(u_image, v_Texcoords).rgb;
	 gl_FragColor =vec4(pow(color, vec3(1.0 / 1.5)), 1.0);	
	
}
