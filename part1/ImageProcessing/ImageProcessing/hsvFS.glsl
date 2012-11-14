varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform int u_frame;

void main(void)
{
	vec3 rgb = texture2D(u_image, v_Texcoords).rgb;
	float m = min( rgb.r, min( rgb.g, rgb.b ) );
	float V = max( rgb.r, max( rgb.g, rgb.b ) );
	float C = V-m;
	float r = (rgb.r)/C;
	float g = (rgb.g)/C;
	float b = (rgb.b)/C;
	float X = C;
	float H = 0.0;

	if( V > 0.0 )
	{
		float S = C / V;

		H = float(mod(float(u_frame*2), 601.0))/100.0;

		float H_ = mod(H,2.0);
		
		X = C * (1.0-abs( H_ - 1.0 ) );
		
		if( H < 1.0 )
		{
			rgb = vec3( C, X, 0 );
		}
		else if( H < 2.0 )
		{
			rgb = vec3( X, C, 0 );
		}
		else if( H < 3.0 )
		{
			rgb = vec3( 0, C, X );
		}
		else if( H < 4.0 )
		{
			rgb = vec3( 0, X, C );
		}
		else if( H < 5.0 )
		{
			rgb = vec3( X, 0, C );
		}
		else
		{
			rgb = vec3( C, 0, X );
		}
	}
	
    gl_FragColor = vec4( rgb+m, 1.0);
}
