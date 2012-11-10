#version 120

varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;
float sobelHorizontal[9] = float[9](-1.0, -2.0, -1.0, 0.0, 0.0, 0.0, 1.0, 2.0, 1.0);
float sobelVertical[9] = float[9](-1.0, 0.0, 1.0, -2.0, 0.0, 2.0, -1.0, 0.0, 1.0);

void main(void)
{
    vec2 accum = vec2(0.0);

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			vec4 original = texture2D(u_image, coord).xyzw;
			float luminance = (0.2125 * original.r + 0.7154 * original.g + 0.0721 * original.b);
			accum.x += luminance * sobelHorizontal[j + i * KERNEL_WIDTH];
			accum.y += luminance * sobelVertical[j + i * KERNEL_WIDTH];
		}
	}	

    float accumLength = length(accum);
	if(accumLength > 1.0)
	{
		accumLength = 1.0;
	}
	if(accumLength > 0.3)
	{
		gl_FragColor.rgb = vec3(0, 0, 0);
	}
	else
	{
		gl_FragColor = texture2D(u_image, v_Texcoords);
		float quantize = 4.0;
		gl_FragColor.rgb *= quantize;
		gl_FragColor.rgb += vec3(0.5);
		ivec3 irgb = ivec3(gl_FragColor.rgb);
		gl_FragColor.rgb = vec3(irgb) / quantize;
	}
	gl_FragColor.a = 1.0;
}
