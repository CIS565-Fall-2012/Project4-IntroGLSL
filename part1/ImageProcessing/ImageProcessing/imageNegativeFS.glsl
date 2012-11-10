varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec4 original = texture2D(u_image, v_Texcoords);
	gl_FragColor = vec4(1, 1, 1, 1) - original;
	gl_FragColor.a = original.a;
}
