varying vec2 v_Texcoords;

uniform sampler2D u_image;
const float A = 1.0;
const float gamma = 0.5;

void main(void)
{
	vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
	vec3 rgb_out = A * vec3(pow(rgb.r, gamma), pow(rgb.g, gamma), pow(rgb.b, gamma));
	gl_FragColor = vec4(vec3(rgb_out), 1.0);
}
