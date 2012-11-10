varying vec2 v_Texcoords;

uniform sampler2D u_image;

void main(void)
{	
	const vec3 W = vec3(0.2125, 0.7154, 0.0721);
	float luminance = dot(vec3(texture2D(u_image, v_Texcoords).r,texture2D(u_image, v_Texcoords).g,texture2D(u_image, v_Texcoords).g), W);
	gl_FragColor =  vec4(luminance);
	//gl_FragColor = vec3(1.0f)-texture2D(u_image, v_Texcoords);
}

//Then set the output r, g, and b components to the lumiance.