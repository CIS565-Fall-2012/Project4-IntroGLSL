varying vec2 v_Texcoords;

uniform sampler2D u_image;
uniform int u_frame;
uniform vec2 u_step;

void main(void)
{
	vec2 scale = vec2( 1.0, u_step.x/u_step.y ) * ( 5.0 + 50.0*( 1.0 + cos( float( u_frame ) / 100.0 ) ) );
	vec3 rgb = texture2D(u_image, floor(((v_Texcoords-0.5)*scale)+0.5)/scale+0.5).rgb;
    gl_FragColor = vec4( rgb, 1.0);
}
