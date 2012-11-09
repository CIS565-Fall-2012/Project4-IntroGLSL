varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{
	
	//negetive image
	vec4 color = texture2D(u_image, v_Texcoords);
    gl_FragColor = vec4(1.0 - color.rgb, 1.0);
	
	
	
}
