varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	gl_FragColor = vec4(vec3(1.0) - texture2D(u_image, v_Texcoords).rgb, 1.0);
}
