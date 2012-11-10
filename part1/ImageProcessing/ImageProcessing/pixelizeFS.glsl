#version 120
varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int TILE_WIDTH = 7; // Odd
const float offset = 3.0;

void main(void)
{
    vec3 accum = vec3(0.0);

	int x_count=int(v_Texcoords.s /(TILE_WIDTH*u_step.s));
	int y_count=int(v_Texcoords.t /(TILE_WIDTH*u_step.t));

	vec2 coord =vec2(0.0);
	coord.x = (x_count * TILE_WIDTH + offset )*u_step.s;
	coord.y = (y_count * TILE_WIDTH + offset )*u_step.t;

    gl_FragColor = vec4(texture2D(u_image, coord).rgb, 1.0);
}
