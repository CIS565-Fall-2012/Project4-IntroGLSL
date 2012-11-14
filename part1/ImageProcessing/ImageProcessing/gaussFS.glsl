varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;

const mat3 kernel = mat3( 0.0625, 0.1250, 0.0625, 
						  0.1250, 0.2500, 0.1250,
						  0.0625, 0.1250, 0.0625 );

void main(void)
{
    vec3 accum = vec3(0.0);

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			accum += kernel[i][j] * texture2D(u_image, coord).rgb;
		}
	}	

    gl_FragColor = vec4(accum, 1.0);
}
