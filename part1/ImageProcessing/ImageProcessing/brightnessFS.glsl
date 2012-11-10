varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	gl_FragColor = texture2D(u_image, v_Texcoords) * 1.2;
	gl_FragColor.a = 1.0;
}
