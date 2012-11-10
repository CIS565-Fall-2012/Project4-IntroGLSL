varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec4 original = texture2D(u_image, v_Texcoords).xyzw;
	gl_FragColor = (0.2125 * original.r + 0.7154 * original.g + 0.0721 * original.b) * vec4(1, 1, 1, 1);
	gl_FragColor.a = 1.0;
}
