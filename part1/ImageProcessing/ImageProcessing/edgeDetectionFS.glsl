#version 120
varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;

const vec3 W=vec3(0.2125, 0.7154, 0.0721);

int sobel_horizontal[9]=int[9](-1,-2,-1,0,0,0,1,2,1);
int sobel_vertical[9]=int[9](-1,0,1,-2,0,2,-1,0,1);
void main(void)
{

     vec2 result=vec2(0.0);
	 float illuminance=0.0;
	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			illuminance=dot(texture2D(u_image, coord).rgb,W);
			result.x+=illuminance*float(sobel_horizontal[i*KERNEL_WIDTH+j]);
			result.y+=illuminance*float(sobel_vertical[i*KERNEL_WIDTH+j]);
		}
	}	
    gl_FragColor = vec4(vec3(clamp(length(result),0.0,1.0)), 1.0);
}
