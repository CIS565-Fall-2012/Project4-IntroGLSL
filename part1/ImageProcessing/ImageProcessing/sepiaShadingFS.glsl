varying vec2 v_Texcoords;

uniform sampler2D u_image;
const vec3 B = vec3(0.299, 0.587, 0.114);
const vec3 A = vec3(1.2, 1.0, 0.8);

void main(void)
{
	vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
	float value = dot(rgb, B);
	vec3 color = value * A;
	gl_FragColor = vec4(color, 1.0);
}
