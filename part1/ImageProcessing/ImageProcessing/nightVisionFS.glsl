#version 120
varying vec2 v_Texcoords;

uniform sampler2D u_image;

const vec3 mask=vec3(1.0,1.0,0.0);

void main(void)
{

	gl_FragColor = vec4( mask * (texture2D(u_image, v_Texcoords).rgb),1.0);
	vec3 color=mask *texture2D(u_image, v_Texcoords).rgb;
	color.r/=(1.0+color.r);
	color.g/=(1.0+color.g);
	color.b/=(1.0+color.b);
	gl_FragColor=vec4(color,1.0);


}
