varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	vec3 temp = texture2D(u_image, v_Texcoords).rgb;

	gl_FragColor = vec4(vec3(temp.r, 0.0, temp.b), 1.0);
}
