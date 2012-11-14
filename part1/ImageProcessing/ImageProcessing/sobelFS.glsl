varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 3; // Odd
const float offset = 1.0;

const mat3 sobel = mat3( -1.0, -2.0, -1.0, 
						  0.0,  0.0,  0.0,
						  1.0,  2.0,  1.0 );

const vec3 W = vec3( 0.2125, 0.7154, 0.0721 );

void main(void)
{
    vec2 accum = vec2(0.0);

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			float lum = dot( texture2D(u_image, coord).rgb, W );
			accum.x += sobel[i][j] * lum;
			accum.y += sobel[j][i] * lum;
		}
	}	

    gl_FragColor = vec4( vec3( length( accum ) ), 1.0);
}
