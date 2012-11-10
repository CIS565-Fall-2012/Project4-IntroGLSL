
varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;

const mat3 sobel= mat3(-1, -2, -1, 0, 0, 0, 1, 2, 1);

void main(void)
{
    vec3 accum = vec3(0.0);

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			
			accum.x += sobel[i][j]*texture2D(u_image, coord).r;
			accum.y += sobel[j][i]*texture2D(u_image, coord).g;

		}
	}

	if (length(accum)>0.5)
	{
		gl_FragColor= vec4(1.0);
	}
	else
	{ 
		float quantize =5; // determine it
		vec3 rgb=texture2D(u_image,v_Texcoords).rgb * quantize;
		rgb =rgb+ vec3(0.5);
		ivec3 irgb = ivec3(rgb);
		rgb = vec3(irgb) / quantize;
	    gl_FragColor = vec4(rgb, 1.0);
	}
}