varying vec2 v_Texcoords;

uniform sampler2D u_image;

const vec3 W=vec3(0.2125, 0.7154, 0.0721);
void main(void)
{
    vec3 color=texture2D(u_image, v_Texcoords).rgb;
	color=(color-vec3(0.5))*2.0+0.5;
	color.r=clamp(color.r,0.0,1.0);
	color.g=clamp(color.g,0.0,1.0);
	color.b=clamp(color.b,0.0,1.0);
	gl_FragColor = vec4(color,1.0);
}
