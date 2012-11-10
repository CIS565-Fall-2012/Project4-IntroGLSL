#version 150

varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;
float mask[9] = float[9](1.0 / 16.0, 2.0 / 16.0, 1.0 / 16.0, 2.0 / 16.0, 4.0 / 16.0, 2.0 / 16.0, 1.0 / 16.0, 2.0 / 16.0, 1.0 / 16.0);

void main(void)
{
	float x = v_Texcoords.s / u_step.s;
	float y = v_Texcoords.t / u_step.t;
	int xDiff = int(x) % 4;
	int yDiff = int(y) % 4;
    if(xDiff != 0)
	{
		x -= (float(xDiff));
	}
	if(yDiff != 0)
	{
		y -= (float(yDiff));
	}
	gl_FragColor = texture2D(u_image, vec2(x  * u_step.s, y * u_step.t));
}
