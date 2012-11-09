varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{

	//calculate noise 
    float noise = dot(texture2D(u_image, v_Texcoords).rgb, vec3(0.4, 0.4, 0.4));
	//multiply with green color
    gl_FragColor = vec4(noise * vec3(0.3, 1.2, 0.3),1.0);

	
}
