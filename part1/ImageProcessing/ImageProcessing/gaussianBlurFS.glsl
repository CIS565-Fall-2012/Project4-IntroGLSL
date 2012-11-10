varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;

void main(void)
{
    vec3 accum = vec3(0.0);
	mat3 mask = mat3(vec3(1,2,1),vec3(2,4,2),vec3(1,2,1))/16.0;

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + /*mask[i][j] * */((float(i) - offset) * u_step.s), v_Texcoords.t + /*mask[i][j] * */((float(j) - offset) * u_step.t));
			accum += mask[i][j] * texture2D(u_image, coord).rgb;
		}
	}	

    gl_FragColor = vec4(accum/* / float(KERNEL_WIDTH * KERNEL_WIDTH)*/, 1.0);
}
