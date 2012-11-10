varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	gl_FragColor =  texture2D(u_image, v_Texcoords);
	//gl_FragColor = vec3(1.0f)-texture2D(u_image, v_Texcoords);
}
