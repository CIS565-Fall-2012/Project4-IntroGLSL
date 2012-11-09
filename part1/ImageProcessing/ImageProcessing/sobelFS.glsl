varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;
const mat3 sobel_horiz = mat3(-1.0, -2.0, -1.0, 
							   0.0,  0.0,  0.0,
							   1.0, 2.0, 1.0);
const mat3 sobel_vert = mat3(-1.0, 0.0, 1.0, 
							 -2.0, 0.0, 2.0,
							 -1.0, 0.0, 1.0);

const vec3 W = vec3(0.2125, 0.7154, 0.0721);

void main(void)
{
    float horiz_accum = 0.0;
	float vert_accum = 0.0;

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			float luminance = dot(texture2D(u_image, coord).rgb, W);

			horiz_accum += luminance * sobel_horiz[i][2-j];
			vert_accum  += luminance * sobel_vert[i][2-j];
		}
	}	

	float gradient_magnitude = clamp(length(vec2(horiz_accum, vert_accum)), 0.0, 1.0);

    gl_FragColor = vec4(gradient_magnitude, gradient_magnitude, gradient_magnitude, 1.0);
}
