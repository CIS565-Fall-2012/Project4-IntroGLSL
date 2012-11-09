varying vec2 v_Texcoords;
uniform sampler2D u_image;

void main(void)
{
	
	 float contrast = 1.2;
	 vec3 contrastCol = (texture2D(u_image, v_Texcoords).rgb - 0.5) * contrast + 0.5;
	 gl_FragColor = vec4(contrastCol,1.0);	
}
