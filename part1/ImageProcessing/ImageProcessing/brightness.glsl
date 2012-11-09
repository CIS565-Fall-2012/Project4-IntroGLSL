varying vec2 v_Texcoords;
uniform sampler2D u_image;

void main(void)
{
			
	float brightness = 0.3;
	vec3 brightCol =texture2D(u_image, v_Texcoords).rgb + vec3(brightness);	
	gl_FragColor = vec4(brightCol, 1.0);
	
}
