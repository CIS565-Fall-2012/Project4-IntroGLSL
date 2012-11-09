varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform vec2 u_step;

const int KERNEL_WIDTH = 5; // Odd
const float offset = 2.0;
const int center = floor( KERNEL_WIDTH*KERNEL_WIDTH/2 );

const vec3 W = vec3( 0.2125, 0.7154, 0.0721 );

void main(void)
{
	vec3 list[ KERNEL_WIDTH*KERNEL_WIDTH ];
	vec2 idx[ KERNEL_WIDTH*KERNEL_WIDTH ];

	for (int i = 0; i < KERNEL_WIDTH; ++i)
	{
		for (int j = 0; j < KERNEL_WIDTH; ++j)
		{
			vec2 coord = vec2(v_Texcoords.s + ((float(i) - offset) * u_step.s), v_Texcoords.t + ((float(j) - offset) * u_step.t));
			int index = i + j*KERNEL_WIDTH;
			list[index] = texture2D(u_image, coord).rgb;
			idx[index] = vec2( dot( list[index], W ), index );
		}
	}	

	for( int i = 0; i < KERNEL_WIDTH*KERNEL_WIDTH-1; i ++ )
	{
		for( int j = 0; j < KERNEL_WIDTH*KERNEL_WIDTH-1-i; j ++ )
		{
			if( idx[j].x > idx[j+1].x )
			{
				vec2 tmp = idx[j];
				idx[j] = idx[j+1];
				idx[j+1] = tmp;
			}
		}
	}

    gl_FragColor = vec4( list[idx[center].y], 1.0 );
}
