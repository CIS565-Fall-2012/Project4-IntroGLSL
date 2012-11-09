varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 3.0;

mat3 gaussMat = mat3(1,2,1,
					2,4,2,
					1,2,1) / 16.0f;

mat3 Sobel_H = mat3(-1, -2, -1,
					0, 0, 0,
					1, 2, 1);

mat3 Sobel_V = mat3(-1, 0, 1,
					-2, 0, 2,
					-1, 0, 1);

const vec3 W = vec3(0.2125, 0.7154, 0.0721);
const float quantize = 3.0;

void main(void)
{
	vec2 accum = vec2(0.0);
	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord1 = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			vec2 coord2 = vec2(v_Texcoords.s + ((float(j) - offset) * u_step.s), v_Texcoords.t + ((float(i) - offset) * u_step.t));
			
			vec3 C1 = texture2D(u_image, coord1).rgb;
			vec3 C2 = texture2D(u_image, coord2).rgb;
			
			float LH = Sobel_H[i][j] * dot(C1, W);
			float LV = Sobel_V[j][i] * dot(C2, W);

			accum += vec2(LH, LV);
		}
	}
	accum = accum / (KERNEL_WIDTH * KERNEL_WIDTH);	
	float length = length(accum);
	
	if(length > (quantize / 100.0))
	{
		gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
	}
	else
	{
		vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
		rgb *= quantize;
		rgb += vec3(0.5);
		ivec3 irgb = ivec3(rgb);
		rgb = vec3(irgb) / quantize;
		gl_FragColor = vec4(rgb, 1.0);
	}
}
